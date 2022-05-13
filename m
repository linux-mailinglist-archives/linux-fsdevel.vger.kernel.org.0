Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DC752670E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 18:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380277AbiEMQal (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 12:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiEMQak (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 12:30:40 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5F395DCA;
        Fri, 13 May 2022 09:30:39 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j10-20020a17090a94ca00b001dd2131159aso11310069pjw.0;
        Fri, 13 May 2022 09:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ouKHIJhtyz2z49p/GFiBli4VgCyFsjzuaI9bnjYF6BE=;
        b=E52EuWR2NYLxNtv5S2qaGtlRceZFTyXzaqLN4lrJtTXIGvVUOETXZBHV7J87JClcjy
         EjUav1nk2VAfm8RlaZ6+sebsuQWVNu0Ek/DGBvVNM3ZmwpjHpeEAfIk0vuk2zW2255UN
         YbHRjWcVGuIWKR+LnxcgKz3tVWwOLKnFzqQ0+tYFrfme9tLLNRLhfPMry+gDtV79xRjL
         yT06S7z2WLQBJYPESRgzfEboM0S5f7AEwFFRsJbxXIPJPzmvM7BvtKowVW7k6Cpgzp1k
         8rhNtp7uMQclAJDopSm2f1QSet8YMu35A63+q9O7bYJnMncJ//hfWrmJQx/es3qRUvuC
         wlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ouKHIJhtyz2z49p/GFiBli4VgCyFsjzuaI9bnjYF6BE=;
        b=LTFJ443xT+BLYkn7phLkolb2/suh1ev/yp2/mUsxvmXcYVP0ely9Fo4wHPgbX32kQj
         MEdYE5vspyrDb5/sA/7IV4zkVqH4XlYR8nwir/TyEq3WVPscBCaWkzFKyq4CcfPdNYW3
         fndKgu3b8pGmTJNX8N6FVIu6oM9FGCvNkSGI6UnOtAcfadiEhqyKXfJMBhDGJI04Nby5
         +KYdhwvxyissvldMfWOMXjwkvPs2CWhdqnZPKBw48E66NFmShs6SZQ1bvqSQeSdCIIQn
         Ik7ZXZfD6x44ZobxP9f5cuYgFIjGY1X/GcelbGvJRJRVLhTi5YMTIL+lVNS+zo7k7U9m
         LhUg==
X-Gm-Message-State: AOAM533D9FdHIFu+2i9Z6Rv+czSzf32q0RB90a9fOzEqSpx82ugI9cwa
        ReSsSf2esTqcBdgooZfnivY=
X-Google-Smtp-Source: ABdhPJwsn2VlrzA8DO4+yV4PnH7NRzTnG+z6ftEh2X3MzzvFD5Dhb1cOFoc8/r4+g26ckptCoWo0Aw==
X-Received: by 2002:a17:902:c409:b0:15e:bdd3:1fa3 with SMTP id k9-20020a170902c40900b0015ebdd31fa3mr5597175plk.67.1652459439193;
        Fri, 13 May 2022 09:30:39 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:5607])
        by smtp.gmail.com with ESMTPSA id n2-20020a63a502000000b003c265b7d4f6sm1818357pgf.44.2022.05.13.09.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 09:30:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 13 May 2022 06:30:36 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Khazhismel Kumykov <khazhy@google.com>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] blkcg: rewind seq_file if no stats
Message-ID: <Yn6HrOLcWR9bol4t@slm.duckdns.org>
References: <CACGdZYLMW2KHVebfyJZVn9G=15N+Jt4+8oF5gq3wdDTOcXbk9A@mail.gmail.com>
 <20220512232907.312855-1-khazhy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512232907.312855-1-khazhy@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 12, 2022 at 04:29:07PM -0700, Khazhismel Kumykov wrote:
> In lieu of get_seq_buf + seq_commit, provide a way to "undo" writes if
> we use seq_printf
> 
> Fixes: 252c651a4c85 ("blk-cgroup: stop using seq_get_buf")

I don't hate it but can you please repost with Christoph Hellwig
<hch@lst.de>? He might have an a lot stronger opinion on it.

Thanks.

tejun
