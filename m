Return-Path: <linux-fsdevel+bounces-19999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850B88CC255
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 15:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410362816C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 13:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96308140E2F;
	Wed, 22 May 2024 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxpZMiGr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B177C13E3EB;
	Wed, 22 May 2024 13:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716385318; cv=none; b=DaRp/7PasiCz7d2gc/8P1Wgt2lOxyzZ7yiOUoiwwqNlYvZOTtDd7eBHT71mguvY2Tqtx2PxwJNgtDjhqn+29ofaD8OwUEIg2oo1Y/tCyfG+bD7Nb9c2KhHxYId46GK3K3RcLbGNp1b/wH3A9ZbRV4VW8CYataB3hONNQOR3BX0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716385318; c=relaxed/simple;
	bh=5OlI2c49kc/GH5J/agNRhgbAvOiepAletVFD/jbVaP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rf7PGcqT5XejVkIpLLSg+2umLdznrYHCD3M7XSOhMs77GvooFPO+QfoXW3QwrI7AXUKP4nL9T3QOQ8MKuNhe3hXm5f7RO/54LUpERRXXBiocti9EWqU8sGxhOIymYScKqTw7QFj4+mbuf+sL/JKwMlZNJ7hKgJeuuOFcpbfhytE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxpZMiGr; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b2733389f9so3109985eaf.1;
        Wed, 22 May 2024 06:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716385316; x=1716990116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meJM/p/T2OemzzcD44JPElMDWWjCdDm6EvOTQof3oOM=;
        b=PxpZMiGrd+XTa8a3+nDs8gKPzoNYoOqpjFozbjDN8zjp0mruKo9wWVd1FFZU3+c/k+
         rlKK2b53Aie+Y+JrrQs3Vi6mzOmQ6jGjBArx1x5utVIyPydFCMka3glE1qARaq+m4UL3
         SVhxlOLik6+O0mO0O2GAjtSTJ6Dwu/7UFJg8VKzyjfqg+z2hErwKckXG1NNbqGdboQ12
         Y+q3UOMTLqHgNZ+l1EBj5HbUhNzw/umElWwZKnrZabXniNztsLnxS7/+U5+XKgQYoVvs
         rVgpbYUdW8ZrUN80EjbDg6LWX+tyaI9Ab/38h3RG/ePRAbi/hKgLqm0umfYrXP3lUZej
         b+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716385316; x=1716990116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meJM/p/T2OemzzcD44JPElMDWWjCdDm6EvOTQof3oOM=;
        b=KVuHzxcJrdArQi7mgdmfoL4Zf2U83lNZlDkCCbf9uode2hSwkAH2gt6c7HU3Dx+jWf
         Lbr5zPH6wKYn39DJ+6NLI5mg3xP29mogvXvZ8pwsmFvhKokJ1ch3sG2DK9XaAlHAYodi
         +qKv4ofRdqguxQiFyKDGAM1UTdRC+XwjPCmxjzEOQnK+a3bMoiMrwIcbpjIUzZA1oTMg
         WctiJrYLeolZNTCXy3yZ7B9AAB2IB8LougSwx/8DXjr3DkLoHMqKUpZXuoih+Kn7CPBE
         CymgkYqntmOtVy9nlE9wvEJwtuw7rNFHCLm+6qLImQN+IUwF4g6GwNWXmKa2uFFmeIyz
         ELcg==
X-Forwarded-Encrypted: i=1; AJvYcCVLCA7UopcqJ4L7K+BUtjDCzxTuXGfKVMm34IOUkTuD2mAWUXzjwPpSUWIy0LsNPR9K01lLP1QE4A41QhWZ+Md5A/gTbOe+qj5fhhkjNKlEH9PDhFdkftndPHPo3by5sCfS/8n68dm2N0G7g40DN+gHW2pyg3YkcS4Qo+mjyebaaSAvgpz1VW3nfHVTExnO/nzkF4fhgB+Z7IkWviJeUZgZPg==
X-Gm-Message-State: AOJu0YxgpH6ipXc2dPlifGsmTAVSVYu0Zd/dMjWrgRqDzOITQY1UnHLk
	OxKv/oNn+lXE8o4vZgNnVNq3vwkMgC3BXPjAhsgGm43HsLLnqOuwtaTOz+qWPQkFaAz/IToHMAr
	GE14dxHHv2MI131iEJglbKQehSqM=
X-Google-Smtp-Source: AGHT+IEJMItiavZC96OOn694KUn/rrJ28jg1RiM7DNQeS56X90KqY7Ko5SU2xqiymo9ES/uF8rC4UK0QhSRV4d/M7TE=
X-Received: by 2002:a05:6358:2826:b0:186:1abe:611e with SMTP id
 e5c5f4694b2df-19791ddd866mr159774755d.30.1716385315608; Wed, 22 May 2024
 06:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708709155.git.john@groves.net> <CAOQ4uxiPc5ciD_zm3jp5sVQaP4ndb40mApw5hx2DL+8BZNd==A@mail.gmail.com>
 <CAJfpegv8XzFvty_x00UehUQxw9ai8BytvGNXE8SL03zfsTN6ag@mail.gmail.com>
 <CAOQ4uxg9WyQ_Ayh7Za_PJ2u_h-ncVUafm5NZqT_dt4oHBMkFQg@mail.gmail.com>
 <kejfka5wyedm76eofoziluzl7pq3prys2utvespsiqzs3uxgom@66z2vs4pe22v>
 <CAJfpegvQefgKOKMWC8qGTDAY=qRmxPvWkg2QKzNUiag1+q5L+Q@mail.gmail.com>
 <CAOQ4uxiY-qHSssaX82_LmFdjp5=mqgAhGgbkjAPSXcZ+yRecKw@mail.gmail.com> <CAJfpegvAuPtKzR1A4GdaZTB_EDqPu53wUf97D1QOUo9VKkTV9Q@mail.gmail.com>
In-Reply-To: <CAJfpegvAuPtKzR1A4GdaZTB_EDqPu53wUf97D1QOUo9VKkTV9Q@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 22 May 2024 16:41:43 +0300
Message-ID: <CAOQ4uxhNWLQQ+mUED18-4Vi7XJv2hGJJ3_j1Yx+wtLZjZaX5eA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/20] Introduce the famfs shared-memory file system
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: John Groves <John@groves.net>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, john@jagalactic.com, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com, 
	gregory.price@memverge.com, Vivek Goyal <vgoyal@redhat.com>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 2:28=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Wed, 22 May 2024 at 12:16, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > The first open would cache the extent list in fuse_inode and
> > second open would verify that the extent list matches.
> >
> > Last file close could clean the cache extent list or not - that
> > is an API decision.
>
> Well, current API clears the mapping, and I would treat the fi->fb as
> a just a special case of the extent list.  So by default I'd keep this
> behavior, but perhaps it would make sense to optionally allow the
> mapping to remain after the last close.  For now this is probably not
> relevant...

Already in the works ;)

Not tested - probably not working POC:
https://github.com/amir73il/linux/commits/fuse-backing-inode-wip

I am trying an API to opt into inode operation passthrough, which
has a by-product of keeping fi->fb around after last close.

This is designed to be setup on lookup, but could also be setup on
first open.

I have some ideas for how to return backing id with lookup
(and readdirplus) response, but haven't tried them yet.
But setup backing file from lookup response will surely
stick around until inode evict.

Thanks,
Amir.

