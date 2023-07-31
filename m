Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278417691A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 11:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjGaJZF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 05:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjGaJYl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:24:41 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7D32D46
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 02:22:43 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9e6cc93c6so13619631fa.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 02:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690795361; x=1691400161;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6jZKxKQtr34g7zzs2GU88CXgRU4juRvxely1NZvAdGQ=;
        b=rSMKIhT9Jyn6JzDRySGPuzYeeGlEXMU+095aMZvC7sHyWhgFbDXbGBr7CSHw/Plh1M
         oAKKDZenrugP99BPLgIVwClPtClbrMEn0ye/g6neElsOONTnanl99uS10U8PunLbL7cc
         JJiGS1h8bzyKpr7kV35+tt7yW4aEcQ4uBxRs5peF4jEhSKNuJAxvdCNgi/9FsxOV0wP4
         4sA/xOz0EPGZQ3pIjafjLZ4H2LFwRANfmGvoyd6Ll+iwqI8E7YSySv1tmYspby3xV9Ve
         snJrUmLJW7y1EbDzauEBRk9VkqSLyskKagVaJo++ho/jlYC8HRq3VYf7PX+4jAnPjCUT
         oyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690795361; x=1691400161;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6jZKxKQtr34g7zzs2GU88CXgRU4juRvxely1NZvAdGQ=;
        b=M8C6U+2Ecqezjow+MkmXWp+9awApj/iDC6BjUIf/Jx0yJUBfYauLHW6fteQFzosqxd
         AeEZDdzT9IJp9/P6wgvsuVw97D0/QouI+VhJOW39uO9xlX7IyG55amOnl+vuWG06nGLV
         x8NUSvnenRt0ejTplzrFCOKbALbjkOLZBwIP7cxwcsxrNr/ORjjTIp8Y0dDkPRjvXli0
         pQwToNdmdk9YVg/j/kITeGg5SOeaJpUlYtHOBGqJdk4U9hIif3zA+HQf80hZ9KVFM2oo
         o7dI7zzgbAvlUquDJPOUC1MD36PwgNdH2zZYhtCSJzP3okgCYRKm9wMc4SiKi+4xJLlP
         558g==
X-Gm-Message-State: ABy/qLb1d0XFIZJmlL3EqU+9hPHg+PWzDsCSsLfnKQbZMucb/S+JYZt8
        FXLWv+3a3IiG2ilosEO44lbrWrQWBU4tSsvhgRw=
X-Google-Smtp-Source: APBJJlFrE4n6gNdAwmLZHHT2twiBwf9Ra3XTNrevzV/moK045fPDRg2zjj9V06VoSxG6tYaxyyNi/Q==
X-Received: by 2002:a2e:90da:0:b0:2b9:d71c:b491 with SMTP id o26-20020a2e90da000000b002b9d71cb491mr3576797ljg.16.1690795361576;
        Mon, 31 Jul 2023 02:22:41 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c22c300b003fe13c3ece7sm6735682wmg.10.2023.07.31.02.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:22:40 -0700 (PDT)
Date:   Mon, 31 Jul 2023 12:22:37 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] maple_tree: make mas_validate_gaps() to check
 metadata
Message-ID: <334c6a06-3416-47b8-9641-6480aac2b522@kadam.mountain>
References: <757b8578-63ae-49cd-8b25-d0abb91ca996@moroto.mountain>
 <5ab4b867-e149-ab92-8a48-b05d14c52550@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ab4b867-e149-ab92-8a48-b05d14c52550@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 04:57:18PM +0800, Peng Zhang wrote:
> 
> 
> 在 2023/7/31 14:34, Dan Carpenter 写道:
> > Hello Peng Zhang,
> > 
> > This is a semi-automatic email about new static checker warnings.
> > 
> > The patch d126b5d9410f: "maple_tree: make mas_validate_gaps() to
> > check metadata" from Jul 11, 2023, leads to the following Smatch
> > complaint:
> > 
> >      tools/testing/radix-tree/../../../lib/maple_tree.c:6989 mas_validate_gaps()
> >      warn: variable dereferenced before check 'gaps' (see line 6983)
> > 
> > tools/testing/radix-tree/../../../lib/maple_tree.c
> >    6982	
> >    6983			if (gaps[offset] != max_gap) {
> >                              ^^^^^
> > Dereferenced.
> > 
> >    6984				pr_err("gap %p[%u] is not the largest gap %lu\n",
> >    6985				       node, offset, max_gap);
> >    6986				MT_BUG_ON(mas->tree, 1);
> >    6987			}
> >    6988	
> >    6989			MT_BUG_ON(mas->tree, !gaps);
> >                                               ^^^^^
> > Checked too late.  This is pointless as well.  Just delete this line.
> Since this is a validator, it is only used for testing, so it will not
> have any impact on normal functionality. I'm not going to delete this
> line, will move it before dereferencing. Thank you for your report.

It will probably still end up generating a warning because MT_BUG_ON()
doesn't actually call BUG().  Smatch actually generates two warnings for
this file.

tools/testing/radix-tree/../../../lib/maple_tree.c:6983 mas_validate_gaps() error: we previously assumed 'gaps' could be null (see line 6950)
tools/testing/radix-tree/../../../lib/maple_tree.c:6989 mas_validate_gaps() warn: variable dereferenced before check 'gaps' (see line 6983)

That business of writing crappier code for the testing/ directory is a
weird thing because it has to be done so specifically to not generate
warnings and debate.  It's sometimes easier in the end to just do it
correctly.

regards,
dan carpenter

