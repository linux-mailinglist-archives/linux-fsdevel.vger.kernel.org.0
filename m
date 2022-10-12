Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338075FC6C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Oct 2022 15:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJLNxJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Oct 2022 09:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJLNxI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:53:08 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6E5C8206
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Oct 2022 06:53:08 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s2so24605704edd.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Oct 2022 06:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wsF7yPfl46SajUdNul+rpmo3/FvWWLzVDqO+YgZCO/8=;
        b=apEOHyUtq60iJWumUy9wzhg8NX/ZLoEPAXvpMjgC+e32gP98RmXVnHRiUwdbSrcX/R
         7vo8ikHIbF8C80v+5aJNCaRm+r8xx8R1EhOTPfTBZc+vwrJmo+VpflKlHGFlrxb2yjJe
         hcBDbCFCL8wXngjfi+97Ja3dt/RajSDaJJN90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wsF7yPfl46SajUdNul+rpmo3/FvWWLzVDqO+YgZCO/8=;
        b=i2RzRCUpOYfB5xcGGp9/Tf8Gx6GzbLG71sRPgy/NpC05tJWNCcALiqd9YRUy6TuQSa
         qFRdapfUBfdBnyujF+QPuw+Ezt2I8n4PFxCmPS9n08tToL50bGHOQ5r0f54GahTO8TT8
         lJVSHppZqVWEf00OBbvFLXGpN/dmlR7DHyz+V2WxI/EgiMUVxfhkPCPZzC1pFviWnJeX
         7npzZP+258rq/neaoorAUCQFdXGbmTkNG9AYXa2rmn1r4MYVve5TiTV9qs4qdTs2JXGE
         cHK7xQqUNpBiCqqlcuMAegNmuA4HAtmdMlYm5hRfxXzk/DN7o63bnV2mMimIvv5pmj88
         IuYw==
X-Gm-Message-State: ACrzQf2StnstFWHV3oKMkhxDXHhq4pcre8An1tOoWRmPrxsQdqlKkzZv
        9wWUtJTTCYAiFAbvvEjOOwnnWoPX2a9pgMpROCNJSg==
X-Google-Smtp-Source: AMsMyM6MHbI9jF9UZa3jx05hTUJHuUtK//lmQJW9lavU34GKxx0MZMu5Cu3OXKm/i4gsF4W3aDjY9ao1vu8GcSSAFyg=
X-Received: by 2002:a05:6402:448:b0:45c:8de5:4fc with SMTP id
 p8-20020a056402044800b0045c8de504fcmr6224275edw.133.1665582786622; Wed, 12
 Oct 2022 06:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220909094021.940110-1-brauner@kernel.org>
In-Reply-To: <20220909094021.940110-1-brauner@kernel.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Oct 2022 15:52:55 +0200
Message-ID: <CAJfpegv96KNAqVoaOcj=P8LY5rVpsfHrHDST=LQuTrSgr4TtVg@mail.gmail.com>
Subject: Re: [PATCH] fuse: port to vfs{g,u}id_t and associated helpers
To:     Christian Brauner <brauner@kernel.org>
Cc:     Seth Forshee <sforshee@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 9 Sept 2022 at 11:40, Christian Brauner <brauner@kernel.org> wrote:
>
> A while ago we introduced a dedicated vfs{g,u}id_t type in commit
> 1e5267cd0895 ("mnt_idmapping: add vfs{g,u}id_t"). We already switched
> over a good part of the VFS. Ultimately we will remove all legacy
> idmapped mount helpers that operate only on k{g,u}id_t in favor of the
> new type safe helpers that operate on vfs{g,u}id_t.
>
> Cc: Seth Forshee (Digital Ocean) <sforshee@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Applied, thanks.

Miklos
