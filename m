Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2037C7941E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 19:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241426AbjIFRKd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 13:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbjIFRKc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:10:32 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865C0DD;
        Wed,  6 Sep 2023 10:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SJz4XT95wezg+B9GJkWziQTgnHcuphiw5Sf/cZrUB04=; b=Ja1eK9E0/smdRgpsTz/bzZdHtM
        gpXXqy7HhjSZqeVmUec0qjzcRFyZgyI9TI+1M95r8dZYTSRuATUvkomnUhltHVxQwcd+sqKewmiPn
        X8Ftmt/PFlooAI009AsllSFFgYTLN965B5zknSaIv9sakWlN8OlSK4RPdWMCBEKBnFh4uXp2DM2gj
        jG1uq8NlZxtDQ4m8JJh0kNLS9C9YN12qiieYALkdlQLzJdmCosnEGAVvOemDCDSDSGl4ZYly+u0yc
        Szjm03hKTCEYQBKMH2AfcuXzYaCPpl0gQkQMxRM0bRMut0+40kEl7hAmOVBo8aRmwViwqhTBpcj1l
        0fgvb1dA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qdw2q-0040cT-0x;
        Wed, 06 Sep 2023 17:10:24 +0000
Date:   Wed, 6 Sep 2023 18:10:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] fix writing to the filesystem after unmount
Message-ID: <20230906171024.GB800259@ZenIV>
References: <59b54cc3-b98b-aff9-14fc-dc25c61111c6@redhat.com>
 <20230906-launenhaft-kinder-118ea59706c8@brauner>
 <f5d63867-5b3e-294b-d1f5-a128817cfc7@redhat.com>
 <20230906-aufheben-hagel-9925501b7822@brauner>
 <60f244be-803b-fa70-665e-b5cba15212e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60f244be-803b-fa70-665e-b5cba15212e@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 06:01:06PM +0200, Mikulas Patocka wrote:

> Perhaps we could distinguish between FIFREEZE-initiated freezes and 
> device-mapper initiated freezes as well. And we could change the logic to 
> return -EBUSY if the freeze was initiated by FIFREEZE and to wait for 
> unfreeze if it was initiated by the device-mapper.

By the time you get to cleanup_mnt() it's far too late to return -EBUSY.
