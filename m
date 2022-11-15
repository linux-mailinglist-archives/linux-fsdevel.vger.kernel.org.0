Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B60F629D42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 16:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbiKOPWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 10:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbiKOPWr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:22:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFB62DA81;
        Tue, 15 Nov 2022 07:22:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8274F61862;
        Tue, 15 Nov 2022 15:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14691C43144;
        Tue, 15 Nov 2022 15:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668525764;
        bh=rxU/qvZkzOWY6f8inhFdxsMbPSlxxghkZ09LKxGURe0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DIcZGyXzNwAwaz1t0O3ryQ9Ycy+iFYflsG3eR2g7/w3bFJeHNGXJbciZ0o79SxHgb
         WgXEwWD5dpImNpG1zJqDZ39IXjugUcs5V+GlGrajbL7gaAOBtm/357+kvx/nX0YARZ
         C9I4sIYp8Q2tU3PlP4emzlumo539dfeNHN8A7+FPNg8ZjQqGIyG/sUoj6xoMNlHb8Z
         d7FzQTCWw0zdQI81Mf0dXgbi8fRA5wP2WmNvW6ZwogLoZR6cwweKXL/4ZEP702raGh
         diPs5b/I+UrG2smIbrWoOOg+9Pso2attIBKqdW2mozwVOQGlHDfJbyqd0TQjSq+o86
         CLXhkFffV7aKQ==
Message-ID: <81a329d44cb2def622ddfcde88984caf51b4a017.camel@kernel.org>
Subject: Re: [PATCH] ksmbd: use F_SETLK when unlocking a file
From:   Jeff Layton <jlayton@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linkinjeon@kernel.org, sfrench@samba.org, senozhatsky@chromium.org,
        tom@talpey.com, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Tue, 15 Nov 2022 10:22:42 -0500
In-Reply-To: <Y3NVZ6e7Hnddsdl6@infradead.org>
References: <20221111131153.27075-1-jlayton@kernel.org>
         <Y3NVZ6e7Hnddsdl6@infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-11-15 at 01:01 -0800, Christoph Hellwig wrote:
> On Fri, Nov 11, 2022 at 08:11:53AM -0500, Jeff Layton wrote:
> > ksmbd seems to be trying to use a cmd value of 0 when unlocking a file.
> > That activity requires a type of F_UNLCK with a cmd of F_SETLK. For
> > local POSIX locking, it doesn't matter much since vfs_lock_file ignores
> > @cmd, but filesystems that define their own ->lock operation expect to
> > see it set sanely.
>=20
> Btw, I really wonder if we should split vfs_lock_file into separate
> calls for locking vs unlocking.  The current interface seems very
> confusing.

Maybe, though the current scheme basically of mirrors the userland API,
as do the ->lock and ->flock file_operations.

FWIW, the filelocking API is pretty rife with warts. Several other
things that I wouldn't mind doing, just off the top of my head:

- move the file locking API into a separate header. No need for it to be
in fs.h, which is already too bloated.

- define a new struct for leases, and drop lease-specific fields from
file_lock

- remove more separate filp and inode arguments

- maybe rename locks.c to filelock.c? "locks.c" is too ambiguous

Any others?
--=20
Jeff Layton <jlayton@kernel.org>
