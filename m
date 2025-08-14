Return-Path: <linux-fsdevel+bounces-57895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D08CB267F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 15:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BDC61CE3B8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 13:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5392C306D2F;
	Thu, 14 Aug 2025 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="SBjsbhDy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEE2305E34
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178602; cv=none; b=Mn5vpuQd4ZCdVm4pNKsOiSbbQfcnfU9kYM057MPItZInGOOYauEP6CXi9/zHQl6WIGJy9XuLfdmId7obiA4HYa7DIPm4kUSoClohhj5d+eIalcSwSqU6AvxeeuJThXsDpYXij5LQWhrUSQy+ffNIUohBedfFlZw6Ujlbsk7HGA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178602; c=relaxed/simple;
	bh=5pu5CCcwVsrYR5S/WgA6wkxRR40hQbEFvk1WFQLNauI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8nqKkF1u7N/Mc4KDmVm+GVHZ8mYza8tvFCCE0BT35f/kkeLM/1mYbzEKW3E3Yc6bV4nfN0zWYiEWJoD53puUUW/ZT6PwdvbnaXNp9F9KidJ1Yw12jGiCDpym2ehHlwofGumFbcCelvQgWgCEulTb71KfV9H5b7t37CmLLtRgM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=SBjsbhDy; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b109c63e84so9369901cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 06:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755178599; x=1755783399; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xiJ+voUm58mOt9ANl6l8BPcmKr+2Gr+D+s+NWbUh7rs=;
        b=SBjsbhDy5LLiWWwzXacdGJQ4Hp/Zf7tp9IRatLTbuO9IWQRQ0hpsacd64hUsDJ/pRx
         m329H7MHaTDl8QgecfN0tW1BXuAtJaL1kgj77NNERPrd5uIwqAFp3DNhVmFir3WDPnGy
         81q1DeQwetE3l+O+0dGR5KayoTZjdCCnzE6m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178599; x=1755783399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xiJ+voUm58mOt9ANl6l8BPcmKr+2Gr+D+s+NWbUh7rs=;
        b=waB3pf7LEfCSGClr3sMTipCz3rOXDUSDURq2LGeS/Mq724FMjT9rZs6JATVefDk+KD
         M01yrbj8Wu+iN3MudvJqMKcRRinv7P+qtm4lAZh9lOYZzKQ3A4Fijuxx2fOS9uEacXLP
         eqs8kPRW4+zYLKKq12ZNG9h3h2Wgf9USUJV+UJQDEe1KPUOCNm7ylqu5CZdJDQUDSEc+
         +QYpQOuzjYAmplP2kHhtd+BVhvtSybBiwCF3Guesk5Y2HqQU5D9YaJX9META0r1JDhNa
         WCE4OnMbA+EB3iqr9tpPbX2zTBux9K0FJ8Wb3Fjl1BhG3htUblJkdO2Wq+GJigBF+gh7
         WP4A==
X-Forwarded-Encrypted: i=1; AJvYcCWLJsRxUe9G1XOM+Cm3rEsshBXGnE+5r1SWQ65KgrJEwMCIt573/024vfjA8XNOiqROS5by7T9otByOmbdO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1NTgXLcuyBsYXeTBcQyu0aKfgnz9wAxQslStkr45Zb3AX9E5p
	1lz7D6pzWS8/fApf4QTW/qjDDS1vypQySqriICbs0zEmrjWZoMffOl1MVcAkVr8Gn4Ch+xhGWTf
	LKkIlE8Oq4jgLyYDyVegAI5ftHzyQ41cu+ShBY1ipdA==
X-Gm-Gg: ASbGnct9ih8s2BXsPL6UOVEXX0NxTJy0tRLeMr+aO+RnY59nlmL2EbKWdznXlvJn3Gj
	1k73EfKmA1kcljoKRqfq4MBjgOyZWFzIfQYgZBEsplVQju0qiR4mtz1vcrlTrARkDb4VtPU1ub2
	gqQ1CFvMKgGdbKkoWPZykyXo7mUaJHIp9A0v4phOkGakPtdxkP2wJhskjJbwwFP4s3u89UlCIQA
	WfW
X-Google-Smtp-Source: AGHT+IGRLUNSdSZic/AfvkGEhcJ0i0UexRhcMwBfu+hTgWYJPH7NmUnalP/saR/GroY1O9C7uFRCx1HrQwBXZpKp4dE=
X-Received: by 2002:ac8:590b:0:b0:4b0:7e22:36bd with SMTP id
 d75a77b69052e-4b10a97a743mr43862441cf.23.1755178598536; Thu, 14 Aug 2025
 06:36:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703185032.46568-1-john@groves.net> <20250703185032.46568-13-john@groves.net>
In-Reply-To: <20250703185032.46568-13-john@groves.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Aug 2025 15:36:26 +0200
X-Gm-Features: Ac12FXz5KYhharzGRoAiyFuPvtQSxT3MxOHi7MhrKR_P4gCMelGIrgjr1IHTKO4
Message-ID: <CAJfpegv6wHOniQE6dgGymq4h1430oc2EyV3OQ2S9DqA20nZZUQ@mail.gmail.com>
Subject: Re: [RFC V2 12/18] famfs_fuse: Plumb the GET_FMAP message/response
To: John Groves <John@groves.net>
Cc: Dan Williams <dan.j.williams@intel.com>, Miklos Szeredi <miklos@szeredb.hu>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 20:54, John Groves <John@groves.net> wrote:
>
> Upon completion of an OPEN, if we're in famfs-mode we do a GET_FMAP to
> retrieve and cache up the file-to-dax map in the kernel. If this
> succeeds, read/write/mmap are resolved direct-to-dax with no upcalls.

Nothing to do at this time unless you want a side project:  doing this
with compound requests would save a roundtrip (OPEN + GET_FMAP in one
go).

> GET_FMAP has a variable-size response payload, and the allocated size
> is sent in the in_args[0].size field. If the fmap would overflow the
> message, the fuse server sends a reply of size 'sizeof(uint32_t)' which
> specifies the size of the fmap message. Then the kernel can realloc a
> large enough buffer and try again.

There is a better way to do this: the allocation can happen when we
get the response.  Just need to add infrastructure to dev.c.

> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 6c384640c79b..dff5aa62543e 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -654,6 +654,10 @@ enum fuse_opcode {
>         FUSE_TMPFILE            = 51,
>         FUSE_STATX              = 52,
>
> +       /* Famfs / devdax opcodes */
> +       FUSE_GET_FMAP           = 53,
> +       FUSE_GET_DAXDEV         = 54,

Introduced too early.

> +
>         /* CUSE specific operations */
>         CUSE_INIT               = 4096,
>
> @@ -888,6 +892,16 @@ struct fuse_access_in {
>         uint32_t        padding;
>  };
>
> +struct fuse_get_fmap_in {
> +       uint32_t        size;
> +       uint32_t        padding;
> +};

As noted, passing size to server really makes no sense.  I'd just omit
fuse_get_fmap_in completely.

> +
> +struct fuse_get_fmap_out {
> +       uint32_t        size;
> +       uint32_t        padding;
> +};
> +
>  struct fuse_init_in {
>         uint32_t        major;
>         uint32_t        minor;
> @@ -1284,4 +1298,8 @@ struct fuse_uring_cmd_req {
>         uint8_t padding[6];
>  };
>
> +/* Famfs fmap message components */
> +
> +#define FAMFS_FMAP_MAX 32768 /* Largest supported fmap message */
> +

Hmm, Darrick's interface gets one extents at a time.   This one tries
to get the whole map in one go.

The single extent thing can be inefficient even for plain block fs, so
it would be nice to get multiple extents.  The whole map has an
artificial limit that currently may seem sufficient but down the line
could cause pain.

I'm still hoping some common ground would benefit both interfaces.
Just not sure what it should be.

Thanks,
Miklos

