Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C1525D10F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 08:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgIDGA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 02:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgIDGA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 02:00:28 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48487C061244;
        Thu,  3 Sep 2020 23:00:28 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id z23so6944785ejr.13;
        Thu, 03 Sep 2020 23:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/RbKFcDe/9p0eCn6PVwL3hGGJ9h1UwG7+EMiD7IMIjA=;
        b=BUUjH6498pxgKlkI7TBQkAxL4YAOzv1LuihEIjbUhMlESZB9pcmBNlol1CXWwjT3QA
         GLzgR1b5EhnjoX1bPYt3Hi+Ahrt4TJ6gkdCjW6PB4FmtMV4zqNCGt9xlA+64OUjDtdeA
         NrrDxCFEgrxrN8exnV279/ZKGMyixFaXASn2kADFjY4/3WaHmmuCEQmWp3MDs66/miJa
         ksLSa3zmEexrNsV7V+5t1v6NG/6WmSqUBJCREH+GegDbN0ai4pgrWp5wyoeIwAAIN5yv
         83ERivChI0D+Ky59cSCS2nhTILw7TgtSN99hoNpdlqipXI1DUcgXY1dIukd08J8Jc2wL
         oG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/RbKFcDe/9p0eCn6PVwL3hGGJ9h1UwG7+EMiD7IMIjA=;
        b=j/uWxs8e/YTk6ynojrmJOSkTjnFZBhz1cXVjh32q5hfmhMw+jA7WekioDnbvv1Zz+V
         Scb3Jz748Mlsia2Wp+1K0R1BB/w4ZC/sLgXRvH8XfZ/1ExyJF7ZtB5es8HwaIBt7DEKN
         eQxjWler0W0LHcLBLOldy4jAEyAdQy6s6irog3xcUqpNGuazuDQ8BsFCxDUV84lF+iTz
         sn+PI90v/kXDKmy/h0wBsQwEcAVf998kzybKCBR+S1hFBPmuYngIGPKIwsMh7PgXliR+
         v/tnqNHp5WDrTER50wOmVNMA/ojhpbsGHsQdvQvXZP3QrXnr954O1R+wyqyDpJAAkCpB
         YfVA==
X-Gm-Message-State: AOAM532gAMFb8FKiRLYD8yJtHZPJAst7wIwed7RImHSa4iIvAYTnwnYc
        ufkSX/YvSV4/xNfnuq5nRRk=
X-Google-Smtp-Source: ABdhPJw7qUGl/jQF6c84gFZcHhRqBS1gA5FSgsoreOSwdAggSpDPGO0dfyGq/1ecMqRsqPeYMPizIw==
X-Received: by 2002:a17:906:a1d7:: with SMTP id bx23mr5864845ejb.273.1599199226711;
        Thu, 03 Sep 2020 23:00:26 -0700 (PDT)
Received: from gmail.com (563BA415.dsl.pool.telekom.hu. [86.59.164.21])
        by smtp.gmail.com with ESMTPSA id r26sm5332257ejb.102.2020.09.03.23.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 23:00:26 -0700 (PDT)
Date:   Fri, 4 Sep 2020 08:00:24 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
Message-ID: <20200904060024.GA2779810@gmail.com>
References: <20200903142242.925828-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903142242.925828-1-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


* Christoph Hellwig <hch@lst.de> wrote:

> Hi all,
> 
> this series removes the last set_fs() used to force a kernel address
> space for the uaccess code in the kernel read/write/splice code, and then
> stops implementing the address space overrides entirely for x86 and
> powerpc.

Cool! For the x86 bits:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
