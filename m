Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306A8749618
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 09:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjGFHMI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 03:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjGFHMH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:12:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416E5DA;
        Thu,  6 Jul 2023 00:12:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8204618A3;
        Thu,  6 Jul 2023 07:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5C9C433C8;
        Thu,  6 Jul 2023 07:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688627525;
        bh=kbamv60wEPXwj8mU3zDEQN6amONWlVjKGsOiI9RmvR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jYmJzVofhzSlU9lW6NJsC/RQYQ2Rs2qaqkIoAiZmgxqNPnMG/y56ih6PzcOfCmnAw
         fWhxBgwHTcET9p/KbBJv7W93rSyimrrZNvVqNOtCXvhiPTY+cWfHHZp9H889X0rU/d
         azVVIOMw8oKcmI8qFXO1PIyU+7ogKGBVssIPJHQbz7tAHGB/GULrjNGatwdiHeirDe
         lhIkRv+oAeEkcjalflRcUaY9KR/2gHQH1P0pg5zKSqmmgJeX2GLS+A1jqLh8fNMEFw
         hVN6qWfaDSjF4/Hlhfz6cWkQnIjfIX4v4GjthX/2+gpDdCBYS9MODO3SkvKvu07n3w
         JdjJw0euf+98g==
Date:   Thu, 6 Jul 2023 09:11:59 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Steve French <smfrench@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Subject: Re: [PATCH v2 06/92] cifs: update the ctime on a partial page write
Message-ID: <20230706-rachsucht-leser-722fdbce7912@brauner>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-6-jlayton@kernel.org>
 <CAH2r5mv+Fc9PuNtb8qMTwpb8qrEO2Tta5+o=mxD-2AY0cU5Aeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH2r5mv+Fc9PuNtb8qMTwpb8qrEO2Tta5+o=mxD-2AY0cU5Aeg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 05, 2023 at 11:50:15PM -0500, Steve French wrote:
> this looks useful (although we have a few more serious problems where we
> don't keep the cached mtime/ctime/size for files that have RW or RWH leases
> so can update the mtime/ctime/size from the server version of it which can
> be stale in cases where we are caching writes (with leases).
> 
> Which tree do you want this patch to go through?

Plan is to take it all through the vfs tree.
