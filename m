Return-Path: <linux-fsdevel+bounces-17632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F388B0AD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 15:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20A4284B7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 13:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298CE15B98B;
	Wed, 24 Apr 2024 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="bZxiilOM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9D515A4B0
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 13:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965264; cv=none; b=ksLLImm6Y9CRLE4y1YeGuiaViDlHyuRJSR8VrGFxgVQcZeNW7YAxup0FLBPDNAmdfnQJsLDyvsMicJcy083TMcFzXU/gPrzjA/gJys0P8DBpyapVH1+ruh5pe82hbrVmjFPIfDQN/agdMmxA6kWOtKJQ1VYZDqach4q599am+l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965264; c=relaxed/simple;
	bh=hVCiT3cVeoDPw8o5TxOi/tzoJPcyStCe54BZO09DgLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmeeFdP7s+93nBU5/NoESi6aky39dFHO5APMbvtHFzAC7A99iFZR39foHkjmmgpbTUapRPBm9JLP/wzLtXmhYs/OgMf0siAoF1HHyt7pBJHouPJKr4fNI05krivX8hPFlUjP2O1q99T37q/ZiW2JFCadyewcl4wX5amq0NhsUq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=bZxiilOM; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78f0592309aso481125485a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 06:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1713965261; x=1714570061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bmaQzf01ImU89PHQrVzq0PujKy/T2pnrZwcrGlSMcAM=;
        b=bZxiilOMgQRR/kRrdlzRTfJzePsgEX5EzxwWMgF/l+ll5TFMAg6WfVXqXlKKbYbEac
         6PNLN6uV72EeJrJJjrRuuXMXy1+nIVu/VbloaOoOggFO+XU0ovbZ/ajz/zUh08TrP1Tc
         315xySGk/H6Q9AUcnQMVCa+FS/EXXOZX7wjx55KUj8sKrhR6ifV+NAjS1hp4lGygvTT1
         QNYkbufwuxaPaEotEP7FJpb1Z/TnxbEs8oqcpnqzlbnJpcrp/LK9czAbdSW/OP0Ni0m/
         wRVBYasNeBx+DcVVRd4vOyJ9zDn4RX1dr4JXzdjfD0IPzRGJmA9HWXz/KJfVnMNsgC71
         iSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713965261; x=1714570061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmaQzf01ImU89PHQrVzq0PujKy/T2pnrZwcrGlSMcAM=;
        b=wQZ+2h1Gat6WAEJ/VvjKdTFb51nMAw96oL5DT+XSjaL3Fvv0aSyyOX9WaokgFDm5wZ
         y8i6IER8Sh/yKyn9y7UjdqQKu+JrtJ2+yP+4D4Dh4ryLkY4IpOsb93Lj0r+ZI6pW0yLV
         eVFX94tcp3lGGtHxGIk1avoCXSglx1nucG0c407MxoVUzZX8kMik437+s5wImp9ybdtb
         HYl1W2KU23VLHwRbIHWEL1mgPs0xcFplfCYiidca/ZK+Z1c9+cCnSMSvQgV8cJpmkfv1
         eb0MEwnJapg4dr1MCGJ9x63CVAAA/i1YKYbHOT7Tbg2X734AelanWkGE/4T3e7UOMg2Q
         zz0A==
X-Forwarded-Encrypted: i=1; AJvYcCWeQ+ddZKqVm2k34n4rHeO1Op+TXLv1fDtf9KfDOYTRjEXl8gJSKqsWrkzp/0I0vdS60Mvrv1PyQl5HRFJ+Tefy9y5Qyy/e2M9uRKs16w==
X-Gm-Message-State: AOJu0Yzyzff7Q8lJYH/oYc46pPUA+0xgMCHjT6oV++9+LKtzVVDyapsu
	qNUVQLhBYU1OYxNdDEZmOsdUGLEy4R9uBmP7TmIAHquQT8efMk65+6vfActjtOk=
X-Google-Smtp-Source: AGHT+IG10JNnau66mb0W0bLsv7g+fqp1h/1IvnkN/qI5c9owHC6AC7QHVsin4Z6bVve3680gH3MsyA==
X-Received: by 2002:a05:620a:40d5:b0:78e:db54:e5fe with SMTP id g21-20020a05620a40d500b0078edb54e5femr3078820qko.11.1713965261163;
        Wed, 24 Apr 2024 06:27:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:9cfb])
        by smtp.gmail.com with ESMTPSA id h6-20020a05620a13e600b0078f044ff474sm6146095qkl.35.2024.04.24.06.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 06:27:40 -0700 (PDT)
Date: Wed, 24 Apr 2024 09:27:39 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz,
	bfoster@redhat.com, tj@kernel.org, dsterba@suse.com,
	mjguzik@gmail.com, dhowells@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] writeback: fix build problems of "writeback:
 support retrieving per group debug writeback stats of bdi"
Message-ID: <20240424132739.GD318022@cmpxchg.org>
References: <20240423034643.141219-1-shikemeng@huaweicloud.com>
 <20240423034643.141219-4-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423034643.141219-4-shikemeng@huaweicloud.com>

Hi Kemeng,

On Tue, Apr 23, 2024 at 11:46:41AM +0800, Kemeng Shi wrote:
> Fix two build problems:
> 1. implicit declaration of function 'cgroup_ino'.

I just ran into this as well, with defconfig on mm-everything:

/home/hannes/src/linux/linux/mm/backing-dev.c: In function 'wb_stats_show':
/home/hannes/src/linux/linux/mm/backing-dev.c:175:33: error: 'struct bdi_writeback' has no member named 'memcg_css'
  175 |                    cgroup_ino(wb->memcg_css->cgroup),
      |                                 ^~
make[3]: *** [/home/hannes/src/linux/linux/scripts/Makefile.build:244: mm/backing-dev.o] Error 1

> ---
>  mm/backing-dev.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 6ecd11bdce6e..e61bbb1bd622 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -172,7 +172,11 @@ static void wb_stats_show(struct seq_file *m, struct bdi_writeback *wb,
>  		   "b_more_io:         %10lu\n"
>  		   "b_dirty_time:      %10lu\n"
>  		   "state:             %10lx\n\n",
> +#ifdef CONFIG_CGROUP_WRITEBACK
>  		   cgroup_ino(wb->memcg_css->cgroup),
> +#else
> +		   1ul,
> +#endif
>  		   K(stats->nr_writeback),
>  		   K(stats->nr_reclaimable),
>  		   K(stats->wb_thresh),
> @@ -192,7 +196,6 @@ static int cgwb_debug_stats_show(struct seq_file *m, void *v)
>  	unsigned long background_thresh;
>  	unsigned long dirty_thresh;
>  	struct bdi_writeback *wb;
> -	struct wb_stats stats;
>  
>  	global_dirty_limits(&background_thresh, &dirty_thresh);

The fix looks right to me, but it needs to be folded into the previous
patch. No patch should knowingly introduce an issue that is fixed
later on. This will break bisection.

