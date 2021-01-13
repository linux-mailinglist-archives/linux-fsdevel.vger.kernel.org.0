Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189CB2F5821
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 04:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbhANCOj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 21:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbhAMV1T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 16:27:19 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2EFC061575;
        Wed, 13 Jan 2021 13:25:52 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id y23so2928539wmi.1;
        Wed, 13 Jan 2021 13:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d2ttguzfCnG+untbMAF3ReX1b0GvXmGr3xjG3ae0DH8=;
        b=EUon2zetws+KLoUAtv+UCUYASs/kjfnGSqsU/cXxtAXwrEkLIhFtYelWrDTx9Ss7HF
         nE9qWCyKVLMmarKu6JJCkho+a8YrZDHc6g6l+WigbLNcEVo1XycyM59IW+w+ZoOc8FFz
         16XISwxMIECxYCxGmKv0EKGObKmlk7+gEVrKR55VXm9DFD8KsjnLo9dbVqiojF2OQ6gk
         6z8xMaNuWfXjf85dz01VlKaV7TSsRRJVqZYcNHa/3BpvEZFJdnS+yb0Y4Tn7r4R4HYdI
         UPI6jMYsSOVoQ95rUN76LCC1tQjU0McSkfbGTj11PbKXudvQ5kLgzGl+MZsmNG5nDOme
         Sifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d2ttguzfCnG+untbMAF3ReX1b0GvXmGr3xjG3ae0DH8=;
        b=A9E6lC0sjO+1KdONpmK6vQdoCOatcQZ4cvTJpcg4bA52aFTmHLodvHDYrQ10ouFkZ6
         WwPbNeqpT8WVmKUsmTCuJEOx9fzDsi2AR8N7CjPZ+Lvf6cZBsWoei8Qpj1QSlkQAt/dN
         DNNqCJ3owkfcNA+OkzJ3JRBI5NNN5+yP7+LSrB76iaSEULmxuIYh7AyjhyGfZECnYSoI
         8VfD9XILTo1N9mjyRoWsa4Ayp7/Mah6jAMH9d5vAPq/Xfjxd5V8JQNamviiuGPh1jYsm
         QrTYqpGp9KgJ56bzLSDzhf/rIAejB6eCrYwOKNk4kflLpnfba8AW0rjKUsk7CUslbZpP
         wEVg==
X-Gm-Message-State: AOAM530sEEVNItK8K73SUlDdn9jvjr1/HW29STfr08tICp/ItwO/O1wS
        ae7RqyB1d89y9TBSXc8AmS9Az83H5fWi
X-Google-Smtp-Source: ABdhPJw6Ziz4Mr0ZsJsU/wzrfCHn5FUsWyRIj/me9CLrVbMFpuGDwdQFdSo4NCWIDu9V3lAPdv67Sw==
X-Received: by 2002:a1c:9acb:: with SMTP id c194mr987942wme.43.1610573151384;
        Wed, 13 Jan 2021 13:25:51 -0800 (PST)
Received: from localhost.localdomain ([46.53.249.51])
        by smtp.gmail.com with ESMTPSA id j13sm4476553wmi.36.2021.01.13.13.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 13:25:50 -0800 (PST)
Date:   Thu, 14 Jan 2021 00:25:47 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Piotr Figiel <figiel@google.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, posk@google.com,
        kyurtsever@google.com, ckennelly@google.com, pjt@google.com
Subject: Re: [PATCH] fs/proc: Expose RSEQ configuration
Message-ID: <20210113212547.GA487841@localhost.localdomain>
References: <20210113174127.2500051-1-figiel@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210113174127.2500051-1-figiel@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 13, 2021 at 06:41:27PM +0100, Piotr Figiel wrote:
> +static int proc_pid_rseq(struct seq_file *m, struct pid_namespace *ns,
> +				struct pid *pid, struct task_struct *task)
> +{
> +	int res = lock_trace(task);
> +
> +	if (res)
> +		return res;
> +	seq_printf(m, "0x%llx 0x%x\n", (uint64_t)task->rseq, task->rseq_sig);

may I suggest

	"%tx", (uintptr_t)	// or %lx

Mandatory 64-bit is too much on 32-bit.

Or even "%tx %08x" ?
