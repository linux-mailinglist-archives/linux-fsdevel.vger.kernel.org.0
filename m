Return-Path: <linux-fsdevel+bounces-60233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BFEB42E8F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 02:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4711BC8272
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 00:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8CD199E9D;
	Thu,  4 Sep 2025 00:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="E+qznanZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248B115624D
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 00:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756947565; cv=none; b=dMjqsYMosKnPwBuvLuVwYBbjJPF8eKIGRtJhDdxE8kfJmx8oNg3ymSapHtzVG9SvGIGkA59cS9IeNl2fKJ75BqAoARDX6Oipehzjm5M3+Iwgj5q5m1PaeVbOU8VG/Jr82CVN4DjeyynF49ROtOgX09m4wVGiQDV7T1ShyzKzP/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756947565; c=relaxed/simple;
	bh=LqKOMnMZAfpiXuUjaiCFZ7Qqbi1FvIZfeGAONez52aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGCEdKa4Cc1ooEbRxutjcvvoYnOtpqIwik7PWbLH5BuDEeUC1HLRCbaC2OwSo4FHMibQiLtBzZQ9d6yHv6IWBxJU2EufDeKazqBhAbbWGVzml00GBWk2wY8yjs2BFoa59sp8af3tajzBNur01rB0tnGPW7J0RRyjOAnQfRAKS+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=E+qznanZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7724fe9b24dso389386b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 17:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1756947563; x=1757552363; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u3GvwTlIRqRrcE9RSws1yhkNXcT0Fb86bqICqyCnRiE=;
        b=E+qznanZzO68NOuOjk0CKQcXpgcPAwej3wFvRWZ8pzhi4fGog5jYKe2+O9VkSOPn4j
         MsT5cvm5Zjkt4FUfTFbOnRglf7WMznxVHQrYz0TWn8rQcS5vsrhw6prbbnxOi1YQ4gzb
         yyXeLHEx6yno5USD68/jz/Rd9NI99OduHKCF3cBJ0yGw6apG06MNM47W4vza0Kh3Ib4S
         EMpPk6l+LYx0qAdaMHKglbiJw4jClwDYjmm2gVRv5RYzBWRVQhJgi4vb+496HEmBCuA7
         0flGvQuOZKciX3HkhbpsLqrmXHuJ8qT6yGPXbUuOde8a3Rc5HbRpHHbyx35hjV7GvM7g
         TyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756947563; x=1757552363;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u3GvwTlIRqRrcE9RSws1yhkNXcT0Fb86bqICqyCnRiE=;
        b=fNBDPmb93wLBQA9ioWhyG+Hya10n4Z7VdaECjMheNeo/Qj0wBDMkdCP9v7bWmu//CY
         j5dryB/lDmVyoF4HW4jfifn+XHT5r8VVaA7+XKX6F0dAVmK0Rj4JJze8ykEPKxAtb/4e
         ZPzbBU5ZgaZ3Ml/kD+7b4QP2PHHGT21LnMQs/PopuV0hOhHIACvOHJ2vsudpaVPpODkF
         okzYanwZ9FEVWoIXktwkuHMDzlFuvQ5YIgltrLU6z23U/8Comnhb1syFnyScu4fAiL7A
         bNnBxpPq58oKFY/ynIcs0nyamlTLNUVdxuuVCKOxU1wpfs7ObYfrLUg/i3l2MsQAMhRn
         vmQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN+emcxJxzVAZLtZXkWrhJetD/WVZMalPnPnEQZyqk7XZyM3wNKnWR8Vb8IcEQlIsrUzpNUI8HLNeRv1tl@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ6k7KVbUqGgknJSxTAMcVoMrAiNbJYkU1atONjADN2ZFZTFxY
	XBtLHsnjWoQTpp2BI2NmmuZGljgHFUdoUUg/tX6TCq0T9qwUtEK+h8lE9gZUNVm1224=
X-Gm-Gg: ASbGncsipJJVcAntXhDTy2l8AjMSUzxPBQzC729+0Fih3AfcqGeR2PqOjcDmmRTglOf
	TJHNwqcVO28WfoHGG/b4hRoijbYy11XYt/zuLzsh3w9fhCBHM61ZC+FPBl/vjJxFeq4RURHOF3L
	SSQc8bNBYkxZ7SkVDlMI+JdnTMER3b24ZFBG9W6powAlNibVTVoO/vXzOTK8Je/c6qSZBVT8nUA
	FbfIyoIIiQYh3Y5BrPM+w+yxgaNJNwB/tcAUqFkVYTVTFFzo0AwYzHTI5bRAm5XoazkadfToibq
	BQdjFIYl4Mm+sZUb1LyDlxBWYeG1giG5t1a7DQ/6v2nqVomkFq67V7hDAl6mTUsVANHsej7g/AR
	gYIrSmytP7PqnVvSErTUxhJaI0ulSvAw7uTIUiq76uKzd3HXgVcXNVFN4ihR1kUtxcxWsx6CN8Q
	==
X-Google-Smtp-Source: AGHT+IGWjhGVrffakImftX7HMuN5xDgaTX10BZo8PPjxryX85jRas4ic+0AC/oRXJ5/9Oo+xit05qg==
X-Received: by 2002:a05:6a20:72a2:b0:243:9ae7:f891 with SMTP id adf61e73a8af0-243d6f4244bmr24090032637.40.1756947563279;
        Wed, 03 Sep 2025 17:59:23 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772590e0519sm10288997b3a.84.2025.09.03.17.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:59:22 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1utyJr-0000000Ex5Q-381y;
	Thu, 04 Sep 2025 10:59:19 +1000
Date: Thu, 4 Sep 2025 10:59:19 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Mark Tinguely <mark.tinguely@oracle.com>,
	Matthew Wilcox <willy@infradead.org>, ocfs2-devel@lists.linux.dev,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] : Re: [WIP RFC PATCH] fs: retire I_WILL_FREE
Message-ID: <aLjkZ1P7vOcfsGvW@dread.disaster.area>
References: <20250902145428.456510-1-mjguzik@gmail.com>
 <aLe5tIMaTOPEUaWe@casper.infradead.org>
 <d40d8e00-cafb-4b0d-9d5e-f30a05255e5f@oracle.com>
 <CAGudoHE4QqJ-m1puk_vk4mdpMHDiV1gpihE7X8SE=bvbwQyjKg@mail.gmail.com>
 <CAGudoHFKmXJGRPedZ9Fq6jnfbiHzSwezd3Lr0uCbP7izs4dhGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHFKmXJGRPedZ9Fq6jnfbiHzSwezd3Lr0uCbP7izs4dhGw@mail.gmail.com>

On Wed, Sep 03, 2025 at 05:19:04PM +0200, Mateusz Guzik wrote:
> On Wed, Sep 3, 2025 at 5:16 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> > On Wed, Sep 3, 2025 at 4:03 PM Mark Tinguely <mark.tinguely@oracle.com> wrote:
> > For now that would indeed work in the sense of providing the expected
> > behavior, but there is the obvious mismatch of the filesystem claiming
> > the inode should not be dropped (by returning 0) and but using a side
> > indicator to drop it anyway. This looks like a split-brain scenario
> > and sooner or later someone is going to complain about it when they do
> > other work in iput_final(). If I was maintaining the layer I would
> > reject the idea, but if the actual gatekeepers are fine with it...
> >
> > The absolute best thing to do long run is to move the i/o in
> > ->evict_inode, but someone familiar with the APIs here would do the
> > needful(tm) and that's not me.
> 
> I mean the best thing to do in the long run is to move the the write
> to ->evict_inode, but I don't know how to do it and don't have any
> means to test ocfs2 anyway. Hopefully the ocfs2 folk will be willing
> to sort this out?

gfs2 calls write_inode_now() from ->evict_inode, so it is definitely
possible to do this.

However, given that ocfs2 is largely a legacy filesystem these days,
I suspect that you are going to have to do this conversion yourself
if you want this approach to progress in a timely manner. :/

-Dave.
-- 
Dave Chinner
david@fromorbit.com

