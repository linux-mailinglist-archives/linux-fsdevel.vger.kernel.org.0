Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7C9523B61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 19:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345444AbiEKRVU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 13:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344439AbiEKRVU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 13:21:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CF0220133B
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 10:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652289678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kriPN3St3WJzr3K/vgIhsu3qaI3q8csTyZqCy+0mias=;
        b=PdE7YW3wiBiPRNf5VvXPeWm3pJcHedshaA6WQQROChgkUbf0gc+20yXuSXz7f6bCNlnUjb
        LHiq76FwF4hzKCrWqB31PyamzzdRDiskLlwNb9w8ICcIq7Lds0RM4yG817agyJ0O9Wg4j5
        4tOkHwTK15bF5p1ouPrQTK+N2RNJzzg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-dyuBveCGMUCIFfZlJaWKLA-1; Wed, 11 May 2022 13:21:15 -0400
X-MC-Unique: dyuBveCGMUCIFfZlJaWKLA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8AF9A185A7BA;
        Wed, 11 May 2022 17:21:14 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.18.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2C2A54CE52;
        Wed, 11 May 2022 17:21:13 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A6CA3220463; Wed, 11 May 2022 13:21:13 -0400 (EDT)
Date:   Wed, 11 May 2022 13:21:13 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Bernd Schubert <bschubert@ddn.com>,
        Dharmendra Hans <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] FUSE: Implement atomic lookup + open/create
Message-ID: <YnvwiZ+s+y3VDUMW@redhat.com>
References: <20220502102521.22875-1-dharamhans87@gmail.com>
 <YnLRnR3Xqu0cYPdb@redhat.com>
 <CACUYsyEsRph+iFC_fj3F6Ceqhq7NCTuFPH3up8R6C+_bGHktZg@mail.gmail.com>
 <YnPI6f2fRZUXbCFP@redhat.com>
 <882fbf7f-a56b-1e82-a158-9e2186ec7c4c@ddn.com>
 <YnQsizX5Q1sMnlI2@redhat.com>
 <CAJfpegseGaWHkjdQj7XiR=TQNFpPZzDF_rTXces2oRz=x0N7OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegseGaWHkjdQj7XiR=TQNFpPZzDF_rTXces2oRz=x0N7OA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 11, 2022 at 11:40:59AM +0200, Miklos Szeredi wrote:
> On Thu, 5 May 2022 at 21:59, Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > Oh, I have no issues with the intent. I will like to see cut in network
> > traffic too (if we can do this without introducing problems). My primary
> > interest is that this kind of change should benefit virtiofs as well.
> 
> One issue with that appears to be checking permissions.   AFAIU this
> patchset only enables the optimization if default_permissions is
> turned off (i.e. all permission checking is done by the server).  But
> virtiofs uses the default_permissions model.

IIUC, only 3rd patch mentions that default_permission should be turned
off. IOW, first patch where lookup + create + open is a single operation
and second patch which does "lookup + open" in a single operation does
not seem to require that default_permissions are not in effect.

So if first two patches work fine, I think virtiofs should benefit too.
(IMHO, 3rd patch is too hacky anyway)

W.r.t permission checks, looks like may_open() will finally be called
after ->atomic_open(). So even if we open the file, we should still be
able to check whether we have permissions to open the file or not
after the fact.

fs/namei.c

path_openat()
{
	open_last_lookups()  <--- This calls ->atomic_open()
	do_open()  <--- This calls may_open()
}

Thanks
Vivek

> 
> I'm not quite sure about this limitation, guessing that it's related
> to the fact that the permissions may be stale at the time of checking?
> 
> Thanks,
> Miklos
> 

