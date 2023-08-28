Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B6978AF64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 14:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjH1MAv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 08:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjH1MAq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:00:46 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1435B11A
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 05:00:44 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99de884ad25so418114066b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 05:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1693224042; x=1693828842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CuUDqM2NsaeUuH23SyDeZCTS67RbYClWKe8875OmLwg=;
        b=B5FOBHozuAEC/efwBgbh9GZcrE3Onwp6yXWKhkAGrq/OaEulMIZr4G9tsmln8MjJ1+
         UtH2AvsGBpzzkeE6wXWIFZa+7KFQsDvvMLqdh5MvgoP8YRDZAoo4Ng6Zb2ln/QGnnEdD
         aYNCuTXs+b7X/22sIgjx4Euk8X7IIJ7XZ5V0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693224042; x=1693828842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuUDqM2NsaeUuH23SyDeZCTS67RbYClWKe8875OmLwg=;
        b=RLrXxGJw06UeBrd8V8tB+IIh79nTmfvBfoLUX5DWMLi12GFXBXbBH/cbuhe070zD+l
         4opoYv6QHRWfUiGk0tCFlV5RfGfu8bMetXcHYAobthQeHEGfBF0j9rFu7ibFzFk9Jb+Z
         w7x0Q76mP31hzwxbH8cHVCn4bdByjZsq8Km+IVGlV7UlwhbNITSBcagSDvPA4BdI8Fef
         0KFe4wiQE8k9y1wpxn1asjb1m+R2CLlo+cYdFV7RpACg2+g5BRHC9ui8YwiEJsq+OMBS
         vCWVhsEvnD3eEfbow78QbmoSTnSPhjw66KT6LSlpbbK9/1/ebHACxzJ9MkSndJJlKKe8
         Rfkw==
X-Gm-Message-State: AOJu0YxKbXKrSYjSVxnJKHB4cUxNwRAAvITsosNtrUBsXY6VwiU2vOcE
        Kb0tYxarCqWhwOyGQ+pIP7WsP2ZLCJt0aodGoQI2bA==
X-Google-Smtp-Source: AGHT+IEqoWXZrp1Uv7M3lzcu+/YrJzwgeUcqqtp2siIoqVKxQZHrOadvCn+Ha4PDm+itUUcMR4nRVD5pb4SgSEgb5Vo=
X-Received: by 2002:a17:907:c019:b0:9a5:b876:b1e3 with SMTP id
 ss25-20020a170907c01900b009a5b876b1e3mr1228857ejc.20.1693224042611; Mon, 28
 Aug 2023 05:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230824150533.2788317-1-bschubert@ddn.com> <20230824150533.2788317-2-bschubert@ddn.com>
In-Reply-To: <20230824150533.2788317-2-bschubert@ddn.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 28 Aug 2023 14:00:31 +0200
Message-ID: <CAJfpegvyw0Qv5vut_Eu4XA_=G1kEnWri6BopMH_iuvgBrcqb8A@mail.gmail.com>
Subject: Re: [PATCH 1/5] fuse: direct IO can use the write-through code path
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        dsingh@ddn.com, Hao Xu <howeyxu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 24 Aug 2023 at 17:07, Bernd Schubert <bschubert@ddn.com> wrote:
>
> Direct IO does not benefit from write back cache and it
> also avoides another direct IO write code path.
>
> Cc: Hao Xu <howeyxu@tencent.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Dharmendra Singh <dsingh@ddn.com>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>
