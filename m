Return-Path: <linux-fsdevel+bounces-35307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E59FA9D3918
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 12:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B75A1F24B7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 11:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9006A1A0BED;
	Wed, 20 Nov 2024 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2J4+Vz1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5097319F464;
	Wed, 20 Nov 2024 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100666; cv=none; b=bCRS/+DHIunWGUvibaSgi5d+FQRy0Gy+xv9R4Lev1xqrWDuwDJqt6jPJpYzN1KgwAy/WiffliaybuVffjFNfD+Ij+wotdiTpmy5q0J/ZtleUvu1Bzp4oL+nb9ep50IWWJpY87Z5+rJR9JgJ++h+ZQJNky0u2XtLGw+1lwdbC/G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100666; c=relaxed/simple;
	bh=HLIF31sLBH0UFLU1mL0HvKWOocAmOPTN1vR/q9fWAxc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zdod6NlfVxG14RFoURJFbN73Ia4PN32rLJlz9a0jQXf/ySDHX/eZ2ksMrLNETesxgOvp7M3feLXn5/RPjX1dBMRuHX5b3xNwJ6awoW0verH6Ud5sCgxqsG3VWlOLoVlHn9G+OKYUEWdUJeP248KJ3+TuOyvTdz6HjSv+rHaedc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2J4+Vz1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so47806665e9.1;
        Wed, 20 Nov 2024 03:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732100662; x=1732705462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hSUV8u/PigmG/RnkK9L9y5PvfBVnhZwSbQHvFo3bfTI=;
        b=g2J4+Vz1NCMqnTwFBD1x7h00iaM6wOwQN7X1p1n35X+HqrAWheczvl93vDULjELIRR
         tZOBioc79/AWW0NhzFgxgdORnjdbJY/FI00PyvPgkJO1asRQVZ4O0U86F7Yxpbgv17He
         T/0fErIgKMnKSU06UG3MOuZEvxj4GYBs37WGvUj8F0+y6OQzYxCgwt8EUuDrB9FP8lp4
         MtrFiOh+EvCzN6Y/Ct1VZ+xcq9h0FrUDW+STHBcryz9cavBqNI3tWgacip1Ib+c0++Ry
         NOrqdSltMyTHwbrjCF9JWLRwxXQAlfv8TjD94i3zGDefnaA4Z7J9LNj1cfBYRKj66u5i
         k3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732100662; x=1732705462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSUV8u/PigmG/RnkK9L9y5PvfBVnhZwSbQHvFo3bfTI=;
        b=I4WCNv2Ny7bDlJpkLVEaSpoLmN6pi7ISzO/NKjt1s/EFSH06JtG3Xo877d3grEpzuq
         x70CwwBiV6tI0lNKUuGU4trrGnOik1TYtAxxfqf6DeHOmS77SMkW7cTQZ1c1JkEpcCHL
         8AsdlHYhGyebbFE2saXG3BsRvuJMqP+5WQy2qu5trBIS0qgnbe4FXEmU1zs09zPJ6+Cx
         k2EGhZZJMocPRcGRRwwZiVSwk/j1gLY2YSVs1GlLMKnfOMXJFdil39bEwBW7278wZ1fS
         hA1jdaWRUYC3Gh3L6IEkKaY9njynmv4QRy+z041VDeQURW26z4Pl/3NF/bEBkUep+bvg
         YFcA==
X-Forwarded-Encrypted: i=1; AJvYcCUhCDwtSO49p5ZBBAYp3F70QrNaeMNeCFuAUkGvhoWtvT1qkUcTtbBlkXLpDS9p9DNvORyHGDKFdt0BeX+sQA==@vger.kernel.org, AJvYcCUtlhHGJQMZLA1Z3JxgwlAaHt13ILia3Qh6f1CiUbTcHGE7ule3QqrWv+fOcKwPQuKwZQoWuVfQrkDgMgJW@vger.kernel.org, AJvYcCWsRhKaGdcFVW2FTIn1gGtgaWNz1fAwQrq/2SlUCohWw3jFquawLBQsYkZP9umxiWQ8lZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3vczGD3xYovSs7RQgmgdu4PK4inG7S0i4SLA2OB8WdIeGByYa
	HNORzjw7332RGWd+4votkyGdo4bctjRxLshz2i80QzTrzTmKrvEl
X-Google-Smtp-Source: AGHT+IFQ7Bytdn5N8T8vu8IeyWK5Lkg6W07FQ6lpT7b0IjOKbcxy5UJ6hV7EtotQ/xH7fh57DPLL+w==
X-Received: by 2002:a05:6000:1448:b0:382:4a66:f4ff with SMTP id ffacd0b85a97d-38254af4fefmr1679670f8f.13.1732100662486;
        Wed, 20 Nov 2024 03:04:22 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825490bee8sm1755590f8f.23.2024.11.20.03.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:04:22 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 20 Nov 2024 12:04:20 +0100
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Juntong Deng <juntong.deng@outlook.com>, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, memxor@gmail.com, snorcht@gmail.com,
	brauner@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Introduce task_file open-coded
 iterator kfuncs
Message-ID: <Zz3CNMZB94Qmy8nY@krava>
References: <AM6PR03MB50804C0DF9FB1E844B593FDB99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB508013A6E8B5DEF15A87B1EC99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <Zz3AG0htZjt9RTFl@krava>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz3AG0htZjt9RTFl@krava>

On Wed, Nov 20, 2024 at 11:55:23AM +0100, Jiri Olsa wrote:
> On Tue, Nov 19, 2024 at 05:53:58PM +0000, Juntong Deng wrote:
> 
> SNIP
> 
> > +/**
> > + * bpf_iter_task_file_next() - Get the next file in bpf_iter_task_file
> > + *
> > + * bpf_iter_task_file_next acquires a reference to the struct file.
> > + *
> > + * The reference to struct file acquired by the previous
> > + * bpf_iter_task_file_next() is released in the next bpf_iter_task_file_next(),
> > + * and the last reference is released in the last bpf_iter_task_file_next()
> > + * that returns NULL.
> > + *
> > + * @it: the bpf_iter_task_file to be checked
> > + *
> > + * @returns a pointer to bpf_iter_task_file_item
> > + */
> > +__bpf_kfunc struct bpf_iter_task_file_item *bpf_iter_task_file_next(struct bpf_iter_task_file *it)
> > +{
> > +	struct bpf_iter_task_file_kern *kit = (void *)it;
> > +	struct bpf_iter_task_file_item *item = &kit->item;
> > +
> > +	if (item->file)
> > +		fput(item->file);
> > +
> 
> missing rcu_read_lock ?

nah user needs to take it explicitly, should have read the whole thing first, sry

jirka

> 
> jirka
> 
> > +	item->file = task_lookup_next_fdget_rcu(item->task, &kit->next_fd);
> > +	item->fd = kit->next_fd;
> > +
> > +	kit->next_fd++;
> > +
> > +	if (!item->file)
> > +		return NULL;
> > +
> > +	return item;
> > +}
> > +
> > +/**
> > + * bpf_iter_task_file_destroy() - Destroy a bpf_iter_task_file
> > + *
> > + * If the iterator does not iterate to the end, then the last
> > + * struct file reference is released at this time.
> > + *
> > + * @it: the bpf_iter_task_file to be destroyed
> > + */
> > +__bpf_kfunc void bpf_iter_task_file_destroy(struct bpf_iter_task_file *it)
> > +{
> > +	struct bpf_iter_task_file_kern *kit = (void *)it;
> > +	struct bpf_iter_task_file_item *item = &kit->item;
> > +
> > +	if (item->file)
> > +		fput(item->file);
> > +}
> > +
> >  __bpf_kfunc_end_defs();
> >  
> >  DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
> > -- 
> > 2.39.5
> > 

