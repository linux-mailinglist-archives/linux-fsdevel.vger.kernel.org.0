Return-Path: <linux-fsdevel+bounces-57913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92384B26AD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 17:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF261C25A79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 15:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2657F225761;
	Thu, 14 Aug 2025 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="nLbSPa6w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875E4221FBC
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184775; cv=none; b=fgSzObKlZKxP5+bhslUOEwrPDhq+fThasf1QKnhQ+xGxDYAIGoWI1ZLt3RjSWFebp1CtSje3Kqf4q783Kt8Pn02Mhy48iPbzASmNi3WMhphSubS7yHHhifbEHQYuvnHZ+4wheeZLb5vIKS0K49HQ/amty7X04KWYKGMc7+p+bjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184775; c=relaxed/simple;
	bh=w0w0dvsu6k/K6PwFlV7vPpkTwV9o99ZgnYkwYYG/8s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlAfRquq0DlAYkhM23GJ2j4BGpdbVLG+VeuxoDU0rs74xW5VQuhFpIA5KRwFQm+Jd8qmv691OzQHPlvZxjVqYBSMAq8ffhAb5ZG8Z3FDWwtXcd6w5LSUAYS0qcm7LTLfO/M9Oy4ugqZ7S923Ajjxeo8Lw4PQ5CUO4WEfD2yXJMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=nLbSPa6w; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b109bd63d0so12909961cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 08:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755184772; x=1755789572; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EA1ZvFf+qWrndIFVkpDd7IpLWJx6+2D8DPmrDSfzpF0=;
        b=nLbSPa6wSfW6iCCBQoxh4+p9jCDfOizqypU73rXtCjn1BgXV957iRTFTtfAR3X1aK2
         ojqSsWGo4QLxAJmi5KwRfXOo3wvWLyp6gyMHoktgawOgtvte0P8E5OPp68kiup5CY1uV
         ENnEaxbmpkhRj84GdnITQXTFiwiooHB35Gat0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755184772; x=1755789572;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EA1ZvFf+qWrndIFVkpDd7IpLWJx6+2D8DPmrDSfzpF0=;
        b=uHnfQ/V9rhLg5k8ldCURdAsi+3nEayAPZyiiCT8SJMpOfgrjBg2btJwCAkctiFgiku
         yV8mb4yK144wbbIQKADx6K0oUhnY8CnuVFNg20TM3wPw6a5/cnUwEF9spWdRvtJWwz9d
         Q6u2vk5I1lFfpXylky6/j5L21OEtc7HQLCdp8rJ8adhNYbCRHDo1YaGuo/lqBRxVKmDp
         QqQogJ6uOanQ21V9hpdYi3LyuhZuUW1zzhmuT/iZ9oaCJ2ECToxdiQ5Y75c7TJVcJL8I
         a3+NulgwUVU//V74PgqAFjyIS8WjNTGMcS4QlHs+9gEPVkzRIBAEg6oGYjwf79mflwK+
         lI5g==
X-Forwarded-Encrypted: i=1; AJvYcCUL/k3JhjpJqftrv1c/wHin2Rn4qJKEou7/1qZ0feHQZz7QC1xAQn8Wi4KVOjlTl0sCJxYaEowLdNjFmgRG@vger.kernel.org
X-Gm-Message-State: AOJu0YxVGTdewCssuUNNA8HStH8DTNfICrl5rTIarNgdZi4mpryU+CJE
	6TbW5eWwO2bN49wDvOw+Fh01b/UzMufDM+LblJhls+25VeuOVi656Lg4Vyw4wCGpXImivZvzZDK
	hWH1jLcITg9kAJBL4PLyF5p/2KMkZuShMYrCRmb/3jg==
X-Gm-Gg: ASbGncvQJrC/6D72fnIf4pduhXez6dm3hvpJvFusl9xAcocAFP7ZVUy6gGdsQNNnmdK
	b70mjACalf40anhdj3C2vehCrgQvd9uhUbwoIv2E7T700ytHHiyjW3DU9KNkZ2eNw4nw1oKMAxt
	jiRBa+WNrLmhDLUJ0fo7fOKxbL2Pwzwap4z7IOCh3tPsFGr0mHq1aWyJv0LO9/ZoadKeTlvQVpV
	sSg/5jp
X-Google-Smtp-Source: AGHT+IG2qa/e3q/lS7fdE17E/mieIqz9XZskfeQdm0xkHvlzBuR85dHk6whip69ESAWWHza3LlnZuCoCgfbTex8i3Ho=
X-Received: by 2002:a05:622a:5c9a:b0:4b0:7327:1bf5 with SMTP id
 d75a77b69052e-4b10a958412mr55498911cf.6.1755184772275; Thu, 14 Aug 2025
 08:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703185032.46568-1-john@groves.net> <20250703185032.46568-12-john@groves.net>
 <20250709035911.GE2672029@frogsfrogsfrogs> <ttjh3gqk3fmykwrb7dg6xaqhkpxk7g773fkvuzvbdlefimpseg@l5ermgxixeen>
 <20250712055405.GK2672029@frogsfrogsfrogs> <CAJfpegspQYVbWVztU5_XFwbGaTQKe2NCm2mcui6J3qv1VDxdSQ@mail.gmail.com>
 <z56yzi6y4hbbvcwpqzysbmztdhgsuqavjbnhsjxp3iumzvvywv@ymudodg3mb5x>
In-Reply-To: <z56yzi6y4hbbvcwpqzysbmztdhgsuqavjbnhsjxp3iumzvvywv@ymudodg3mb5x>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Aug 2025 17:19:20 +0200
X-Gm-Features: Ac12FXw8eO26MUJ86ncWZmuTB9wijlUFGNEwkcMvFc2CD_KfkHGAKLg17yDdXIs
Message-ID: <CAJfpegsQxSv+x5=u1-ikR_Pk7L+h_AqNBW1XxM-b1G2TLPP4LA@mail.gmail.com>
Subject: Re: [RFC V2 11/18] famfs_fuse: Basic famfs mount opts
To: John Groves <John@groves.net>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Aug 2025 at 16:39, John Groves <John@groves.net> wrote:

> Having a generic approach rather than a '-o' option would be fine with me.
> Also happy to entertain other ideas...

We could just allow arbitrary options to be set by the server.  It
might break cases where the server just passes unknown options down
into the kernel, which currently are rejected.  I don't think this is
common practice, but still it sounds a bit risky.

Alternatively allow INIT_REPLY to set up misc options, which can only
be done explicitly, so no risk there.

Thanks,
Miklos

