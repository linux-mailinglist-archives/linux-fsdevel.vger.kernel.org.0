Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C411E681C0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 22:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjA3VBU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 16:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjA3VBT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:01:19 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0451146148;
        Mon, 30 Jan 2023 13:01:18 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id mi9so3134845pjb.4;
        Mon, 30 Jan 2023 13:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WgaU3PyU9V/rnheQiNO438CyYuOMtd/iZANffKMTbLA=;
        b=bwFOvqHoh7o5sr6095EUEjgd0hLeXMnuhFxhy5S8f2WjMfxN5reo0UpRvJyblxjoHa
         awo4yTFcvo6bHl1e4exDW8DJRb+5eseg/T5IaGpyssl7s5UFUglmTqHeEs1QlJ9jG9KA
         dcvGIIyNWEPIzh7aurUCd66RrlfpbWaMtU/27Wr/van33wpfhgPJOWt6XcYqHl20aR2x
         2Rha6LJ47+cLNceSQLTpbzo9ZbnIpuq9mL+3hslwBz1EiDErLWTOxZ7seSZ1eNg8pbb/
         m3WUXgIpP43nIjW7rvO8jmy7NVHizuGeKnVeTRNzG1wq9uL70UsrFU4zvSSMURjCC6s6
         owyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgaU3PyU9V/rnheQiNO438CyYuOMtd/iZANffKMTbLA=;
        b=xheVSZA8LxyOcx5QW/z+lw/vv3NnqquKsa+2ry6bLMg5exKHKEhOc/ZQ2IrpPoJ+wk
         bKsqR1NnHP3uCGwfE/kGGprXtzNVftqaZknbvylrOXohRAEfnFwnpghYgS+TJqsRsoTq
         3dWY02ACbVmXmvuJ9MFp17sEhHh/rN/Ckdf+dCCG5JZtsE+fFiS5gGnlBVTK1vVJU33G
         fe4FnJVmsGaQfmEa611wxd5Y3AcSTbG+0+GpzbLQFRj0khHSo2v8xxSKx1bgDGnNWeWn
         55vKYqtQlaUZWxAbYF/UvWp4Wea7T7k4VIePcdBaTKGSjddSntpaoyU5ttwwXNXy6Mi8
         kIdA==
X-Gm-Message-State: AO0yUKW4AMZUHKAVGRh9JP6icab9IPT8wkiqIUmMPDxuHBI6SWN9dXoy
        LG9pZGiPu6xEpmrf/LZc6Rw=
X-Google-Smtp-Source: AK7set9qh142u6/TNcf5UedgvTLEq/dCcUOs4EIPNMoawLafI34/pZPbb4ChftcKILW4gx7FSvEukA==
X-Received: by 2002:a17:90b:33ce:b0:22b:ec81:c36c with SMTP id lk14-20020a17090b33ce00b0022bec81c36cmr26723309pjb.45.1675112477514;
        Mon, 30 Jan 2023 13:01:17 -0800 (PST)
Received: from localhost ([2406:7400:63:1fd8:5041:db86:706c:f96b])
        by smtp.gmail.com with ESMTPSA id z92-20020a17090a6d6500b0022c2e29cadbsm7336471pjj.45.2023.01.30.13.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:01:17 -0800 (PST)
Date:   Tue, 31 Jan 2023 02:31:13 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv2 0/3] iomap: Add support for subpage dirty state tracking
 to improve write performance
Message-ID: <20230130210113.opdvyliooizicrsk@rh-tp>
References: <cover.1675093524.git.ritesh.list@gmail.com>
 <Y9gIAKOVAsM2tTZ5@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9gIAKOVAsM2tTZ5@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23/01/30 06:10PM, Matthew Wilcox wrote:
> On Mon, Jan 30, 2023 at 09:44:10PM +0530, Ritesh Harjani (IBM) wrote:
> > TODOs
> > ======
> > 1. I still need to work on macros which we could declare and use for easy
> >    reference to uptodate/dirty bits in iop->state[] bitmap (based on previous
> >    review comments).
>
> I'm not sure it was worth posting this series without doing this, tbh.

Really sorry about that. Since there was a functionality changes in
this patches which were earlier missing from the last series that you pointed
out i.e. marking the bits dirty when the folio is marked dirty, along with one
other change which I mentioned in cover letter. So I thought of pushing these
changes to get some early review.

Sure, I will definitely work on it and will push out the next rev with these
changes included.

>
> > 5. To address one of the other review comments like what happens with a large
> >    folio. Can we limit the size of bitmaps if the folio is too large e.g. > 2MB.
> >
> >    [RH] - I can start looking into this area too, if we think these patches
> >    are looking good. My preference would be to work on todos 1-4 as part of this
> >    patch series and take up bitmap optimization as a follow-up work for next
> >    part. Please do let me know your thoughts and suggestions on this.
>
> I was hoping to push you towards investigating a better data structure
> than a bitmap. I know a bitmap solves your immediate problem since
> there are only 16 4kB blocks in a 64kB page, but in a linear-read
> scenario, XFS is going to create large folios on POWER machines, all
> the way up to 16MB IIUC.  Whatever your PMD page size is.  So you're
> going to be exposed to this in some scenarios, even if you're not seeing
> them in your current testing.

Got it!! Let me come back on this after giving some more thoughts.

-ritesh
