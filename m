Return-Path: <linux-fsdevel+bounces-35306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 978409D38D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 11:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446AD1F258EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 10:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3364F19E826;
	Wed, 20 Nov 2024 10:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkBfVSFb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1330A19C551;
	Wed, 20 Nov 2024 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100129; cv=none; b=bWdxkTdXtFYhx1LQuOxal8juW2/nHT14XH+0T4g3P/B+kveY3qgdfZJN/cQw8gpSIWX3rZLdBWMnGzCJuZsI2IYlAz2hj0kVSdVRB24IMXKKdQwSNQgBKmRQAkjdQxutx1tLZg01TMjqBbKaL1zip8tTS0vWBlfyQbqNVPxDWfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100129; c=relaxed/simple;
	bh=5fAO1WmNHsbkwm5ApUCHwwKfxltnVmGaCcB8bsehc/M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D94q1fqeVRxy/wva+uylywGLMabmsQWC3CTDYxjSLn0BcgpbIYGm2kkw6fbTnB6t5lkCkX5w85+RR/Djb5G8MMDdToLrFD6KxpqRfwwPmGS0ghTuTIup+HcBgKLmRqxP6MdARaMUq4UC+SbyoGaso50hugxKdh+2QQAfWU3GHyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkBfVSFb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa1e51ce601so774024666b.3;
        Wed, 20 Nov 2024 02:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732100126; x=1732704926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bZ832vKXSaqdK6+2qvAMZI0ii8aOixUcx8WfJ8JlLv0=;
        b=AkBfVSFbVbPbNvC5nSEwUdZ6NXpyeUfnDneaA3TZ3GpJJdtfTDJlNq09fZ+o5DbHPC
         MPQBdSb/zYEtJNIRON8gek1WGsaQfyA/h1bD+oYSVfDbPo5FPSFr4fb7KAfenTriFPXQ
         1tzX9/htduYBrjx4gC57mRfQLvPiEQ5CcDRvJsy1EJ4zE33nQmdcRGt/mlJsOGu7Wye5
         nUJwkPllODp8N5ZufbFWB+Uz5MiqxI8sJUiT33fb/B3l8OW376QitTSSsYH13mUOVIc4
         Q4kxBb943uYhMgeLaGVj8fp08Nnz56EdLN+i596cUfFU/R+xC6ehAJKZ+yX/Jv4CeFzY
         fqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732100126; x=1732704926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZ832vKXSaqdK6+2qvAMZI0ii8aOixUcx8WfJ8JlLv0=;
        b=eTQDw7trB109bXm0bm3j6aAdfIEnfGS3pa65fELoDneDK1RK6g62NPm7/9tXxyblBN
         Ua+t4xFu0SGrgmscHvIKjFaEjqo1mynLYWXlffx56Ki4sg4P5KfN2OxhlIRBflp+vJs7
         5FqpgFjNJuvYSMxoMGMZZRdhPXtFWnFIwd374Y1VuLCvMNMw6d2hEG+p/b/MRY897SAf
         DGOrgS+sof8xS/0hmvtv/1DFTxBXZECTM6ZuYr+2pFS/iMOGQchZGN76JBW+QQKu6eZI
         N/4vP/WxZblDj+XA5DtTvvepP1aZ3GXHpH6keQ/7gqL4FO4zxF01yD1qUc47s12xQATc
         mIiA==
X-Forwarded-Encrypted: i=1; AJvYcCUuC+TvN7xtPDy6o5hddPKPWcfDTHLXVmKKkiN6hl4V6b0QBGr7l7Ta3OGwEXGKBebBvjSDvBJ5IoT58p88/g==@vger.kernel.org, AJvYcCVCo6tTaCobizMwuTWTuuikK0t0Qww80DFr3cUaDXtXvmQsJ8Dtm5M5mKHiTX4z1DKrO18=@vger.kernel.org, AJvYcCWXoQkgXPJ51zBNLB90J4k93Gg96GC9hHzVAo6+42dXRF0PCD8oQtIlPU13fgFEGOANx8UYmZm6NG3Jnt3H@vger.kernel.org
X-Gm-Message-State: AOJu0YyIKf17O4remfxGrZBBOI09Dkf0xm/TLg/GWiqz1W/MjT6CntfB
	smBYWpUk80dF+ajE6qPZIwRD3usq8chafQsBJKFg+cwBq/34em3Z
X-Google-Smtp-Source: AGHT+IFXmsOSAoa+aCWV/3Pq4idAxDbgFh0yb212Bgl0eSG0cXGpq+b2iVUhk3XUjdBPp97jt/v2Rw==
X-Received: by 2002:a17:906:6a08:b0:aa4:9ab1:1982 with SMTP id a640c23a62f3a-aa4dd548167mr196917766b.4.1732100126159;
        Wed, 20 Nov 2024 02:55:26 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e042ed1sm751701466b.134.2024.11.20.02.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 02:55:25 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 20 Nov 2024 11:55:23 +0100
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, memxor@gmail.com,
	snorcht@gmail.com, brauner@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Introduce task_file open-coded
 iterator kfuncs
Message-ID: <Zz3AG0htZjt9RTFl@krava>
References: <AM6PR03MB50804C0DF9FB1E844B593FDB99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB508013A6E8B5DEF15A87B1EC99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR03MB508013A6E8B5DEF15A87B1EC99202@AM6PR03MB5080.eurprd03.prod.outlook.com>

On Tue, Nov 19, 2024 at 05:53:58PM +0000, Juntong Deng wrote:

SNIP

> +/**
> + * bpf_iter_task_file_next() - Get the next file in bpf_iter_task_file
> + *
> + * bpf_iter_task_file_next acquires a reference to the struct file.
> + *
> + * The reference to struct file acquired by the previous
> + * bpf_iter_task_file_next() is released in the next bpf_iter_task_file_next(),
> + * and the last reference is released in the last bpf_iter_task_file_next()
> + * that returns NULL.
> + *
> + * @it: the bpf_iter_task_file to be checked
> + *
> + * @returns a pointer to bpf_iter_task_file_item
> + */
> +__bpf_kfunc struct bpf_iter_task_file_item *bpf_iter_task_file_next(struct bpf_iter_task_file *it)
> +{
> +	struct bpf_iter_task_file_kern *kit = (void *)it;
> +	struct bpf_iter_task_file_item *item = &kit->item;
> +
> +	if (item->file)
> +		fput(item->file);
> +

missing rcu_read_lock ?

jirka

> +	item->file = task_lookup_next_fdget_rcu(item->task, &kit->next_fd);
> +	item->fd = kit->next_fd;
> +
> +	kit->next_fd++;
> +
> +	if (!item->file)
> +		return NULL;
> +
> +	return item;
> +}
> +
> +/**
> + * bpf_iter_task_file_destroy() - Destroy a bpf_iter_task_file
> + *
> + * If the iterator does not iterate to the end, then the last
> + * struct file reference is released at this time.
> + *
> + * @it: the bpf_iter_task_file to be destroyed
> + */
> +__bpf_kfunc void bpf_iter_task_file_destroy(struct bpf_iter_task_file *it)
> +{
> +	struct bpf_iter_task_file_kern *kit = (void *)it;
> +	struct bpf_iter_task_file_item *item = &kit->item;
> +
> +	if (item->file)
> +		fput(item->file);
> +}
> +
>  __bpf_kfunc_end_defs();
>  
>  DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
> -- 
> 2.39.5
> 

