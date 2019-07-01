Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDBD75BA77
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 13:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfGALT4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 07:19:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58952 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbfGALT4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:19:56 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hhuLf-00038r-6I; Mon, 01 Jul 2019 11:19:51 +0000
Date:   Mon, 1 Jul 2019 12:19:51 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] vfs: move_mount: reject moving kernel internal mounts
Message-ID: <20190701111950.GY17978@ZenIV.linux.org.uk>
References: <20190701010847.GA23778@ZenIV.linux.org.uk>
 <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com>
 <20190629202744.12396-1-ebiggers@kernel.org>
 <20190629203916.GV17978@ZenIV.linux.org.uk>
 <2578.1561966690@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2578.1561966690@warthog.procyon.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 01, 2019 at 08:38:10AM +0100, David Howells wrote:
> Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > 	/* The thing moved must be mounted... */
> > 	if (!is_mounted(old_path->mnt))
> > 		goto out;
> 
> Um...  Doesn't that stuff up fsmount()?

Nope - check is_mounted() definition.  Stuff in anon namespace
*is* mounted there, so that's not a problem.

FWIW, is_mounted() would've been better off spelled as
ns != NULL && ns != MNT_NS_INTERNAL; the use of IS_ERR_OR_NULL
in there works, but is unidiomatic and I don't think it yields
better code...
