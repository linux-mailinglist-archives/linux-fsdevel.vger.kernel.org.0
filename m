Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85896E1435
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 20:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjDMShG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 14:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDMShF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:37:05 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17A97AB0;
        Thu, 13 Apr 2023 11:37:02 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ud9so39543837ejc.7;
        Thu, 13 Apr 2023 11:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681411021; x=1684003021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ctjyu73iM54aIyhlbCG/deKG/CTsP8kAywi8XWV3uyI=;
        b=OA4zI3Uq/q5iAEVUQDYMIt2ftZ72Y3PEesQ3ZnQbkiO1nXrM2v/+xv14KbO86QfJF2
         KStCCliQ4dXztgQa1hVtVmqCS+2s0X/8kN7OfqiTph9SynNXPanELDUmg2eZEoX5MbCO
         zI8W4RMkc8NZMhzmvVSy6EF43NI0yXTn9LQWUcIcLi+Y9ZuDbMCiCShWhBiFEyFZlPx+
         IllgFY2zc3TM8h00+q/QRA3v81ANYuwdi+jJg69HsgnoJiKYN2jq7T8qMi3u2oqmKEyO
         ka3wfkSrvzwh35aUsCAMmytOqqx9HI/DOXDpO1EUcNCEn2vAHZsNRTxGyi+doJ2h6RI7
         BYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681411021; x=1684003021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ctjyu73iM54aIyhlbCG/deKG/CTsP8kAywi8XWV3uyI=;
        b=d7e4Duvy/73gObUvm3hp6Hu4AxVmIqeBOh0CJkB2ZkdTzNBWEewVUStJso2xfTKjd9
         uIOPlBu2PVqtLnmnEySj5jiPWdXkA+rFzogYeZDf6/xAcsfwuoJ2RykdHAe+mIkBSHCI
         HQeXcnGHpmM/xedHfVjGIRzO7EqdEoxL6+DNtgkFWxYJ0IafEa3WMBGW2n7jwhLUI8jx
         4avMVLq4Gj61tv8rSc3MFJrlfC43pgykvEGTKxOUHCBBK9EBlihSTFPQzdR/reg9rS1l
         20lQp0q7gRQD7t2z0Kv2nG8e0Hi3gkfvE4WM1CE5pxaB8//sPdfdcoVxB6U4ltWO0Ec+
         OboA==
X-Gm-Message-State: AAQBX9f0/F4gfDkp1UkYhxdz2Iu0QtlVpEr+CiSdKT+jSKMAGRRIqdcZ
        kVW0eXtRMdQRVLYl7Zwwqnk0fmDfsg==
X-Google-Smtp-Source: AKy350bW9uOb3WYUA3v/brxo+veLe07VYr/JDy+8LcWabxZ1ztGNMbox44ItKnSuTbK7wm7zGKYm6Q==
X-Received: by 2002:a17:907:20b2:b0:94e:6b12:caab with SMTP id pw18-20020a17090720b200b0094e6b12caabmr3593954ejb.51.1681411021214;
        Thu, 13 Apr 2023 11:37:01 -0700 (PDT)
Received: from p183 ([46.53.248.76])
        by smtp.gmail.com with ESMTPSA id mh21-20020a170906eb9500b0094e4d197160sm1281817ejb.202.2023.04.13.11.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 11:37:00 -0700 (PDT)
Date:   Thu, 13 Apr 2023 21:36:58 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chunguang Wu <aman2008@qq.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/proc: add Kthread flag to /proc/$pid/status
Message-ID: <59774223-680e-4b64-87ea-ab7e524be369@p183>
References: <tencent_3E1CBD85D91AD4CDDCB5F429A3948EB94306@qq.com>
 <20230412141216.c8f2c1313f34ee0100ac9ae4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230412141216.c8f2c1313f34ee0100ac9ae4@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 12, 2023 at 02:12:16PM -0700, Andrew Morton wrote:
> On Wed, 12 Apr 2023 22:34:02 +0800 Chunguang Wu <aman2008@qq.com> wrote:
> 
> > user can know that a process is kernel thread or not.
> > 
> > ...
> >
> > --- a/fs/proc/array.c
> > +++ b/fs/proc/array.c
> > @@ -434,6 +434,12 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
> >  
> >  	task_state(m, ns, pid, task);
> >  
> > +	if ((mm == NULL) || (task->flags & PF_KTHREAD)) {
> > +		seq_puts(m, "Kthread:\tYes\n");
> > +	} else {
> > +		seq_puts(m, "Kthread:\tNo\n");
> > +	}

"mm" check is redundant. PF_KTHREAD should be enough.
If you're doing this, just print 0/1. 

> >  	if (mm) {
> >  		task_mem(m, mm);
> >  		task_core_dumping(m, task);
> 
> Well..   Why is this information useful?

I want to add: for a shell script.
Real programs can read /proc/*/stat .

> What is the use case?
> 
> There are many ways of working this out from the existing output - why
> is this change required?
