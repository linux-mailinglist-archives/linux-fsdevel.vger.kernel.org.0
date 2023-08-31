Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7A878F16B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 18:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345769AbjHaQlZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 12:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbjHaQlY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:41:24 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDBD12F
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 09:41:21 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bf6ea270b2so7235745ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 09:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693500081; x=1694104881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UO6pqyK10xxtcpdFIBil60H7lDX6OkZTct96m5CdV+k=;
        b=oeHjSbP/6dhM3fr5tS/NHXokCICG/aUMjnh47CXrA1O/pTPRyjS/cggaErbfU/c/N6
         N/Ud0BcSaZ5dCBCwnjGrDmxBicckD/Dc4+wCXkqh5w4gyBGmbtNyXxZFvgiCq8QalKa8
         DmgvBr1iQmfnYLfL14x4XEa1tvtKzpqsrtZyECzWq8+T8mYdickPr1l2jf9h0CkHffzT
         JVorClkr9h2JU/BEybTHGgYjo7TPk+OMFY+5eoGLOVoEvPrNOIJTwyWkQjg3PBYTnWLF
         bI0AkoQRkXk3PA0mAUxgjnDW3PuFihFfTaG1wbb8sDfbEeqdlfnvswLOjRmVBlvEUO38
         TCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693500081; x=1694104881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UO6pqyK10xxtcpdFIBil60H7lDX6OkZTct96m5CdV+k=;
        b=aF4/s36K/D+i2k2KIyPMwedtnBZnGtiX6hhcK2CSRR+D24ys24Rtvnghpt236Cf/Xo
         TKKNqyQCVoI7WBHhzn2tBtPK5FIsiqfS57OPIjsn3A6dllen0tdIqYcPwOOH8UiKimAz
         WPxBy7wY8hvxJu3R/6c+y1aPJXzjitYYi77GnN/Dsklsle+eAJwSqmoskLYOkmCw91Q9
         z8nGSP4zV4DvZyHr9h0BlHOyx7k4qdOwNaycZWHsk2rfOvI3jk45YzU/1pU+mkMK361Q
         zac8LyiSgXZpdVfUFG64gzj1Y6I5u+LVQHiiYCFbbVAl8jNqGjIT9cQGQja50rVBN8rW
         CHCA==
X-Gm-Message-State: AOJu0Yyc5npWVAaxDl56i4LvQuOuZ6od2kzaFCaZRnyiC1FH9C7DdZGZ
        1Y20kKmER/Mx83jHT813InWzaw==
X-Google-Smtp-Source: AGHT+IG1MfNklZsEKSo6sQRl8EAAG9/w3oikkT83M4JC4OzEIjaR15+W1LxNMxkxLd2D9xQHficg5w==
X-Received: by 2002:a17:902:a410:b0:1b3:ea47:796c with SMTP id p16-20020a170902a41000b001b3ea47796cmr187614plq.29.1693500080251;
        Thu, 31 Aug 2023 09:41:20 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902c94200b001b392bf9192sm1457492pla.145.2023.08.31.09.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 09:41:19 -0700 (PDT)
Date:   Thu, 31 Aug 2023 16:41:13 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v5 03/45] binder: dynamically allocate the android-binder
 shrinker
Message-ID: <ZPDCqbjJzueiEReu@google.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
 <20230824034304.37411-4-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824034304.37411-4-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 24, 2023 at 11:42:22AM +0800, Qi Zheng wrote:
> Use new APIs to dynamically allocate the android-binder shrinker.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Carlos Llamas <cmllamas@google.com>
> ---

Looks good to me, thanks!

Acked-by: Carlos Llamas <cmllamas@google.com>
