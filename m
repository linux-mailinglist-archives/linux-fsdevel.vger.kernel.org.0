Return-Path: <linux-fsdevel+bounces-12995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 189F4869E41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 18:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA74D1F248A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 17:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5192313AA27;
	Tue, 27 Feb 2024 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfWPtj3j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EEA54FAC;
	Tue, 27 Feb 2024 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056108; cv=none; b=Iyn+WHHAjiK5Gxwk02VxmCNraovfb5VMKw5yPIYQIk0zarQaNUd1HgrCdkJgU7QojieCW3nb9SRCH89iaCHbhaJxUTp6zLWc/t0p5L/hiDQspwWbFP5s0Lx4vR62oSchAL/N1cS87ElLW/WrBjkAQ/141hAq9sL60SBp0owp9Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056108; c=relaxed/simple;
	bh=vl3+kSJl9raKx1cJiC5v+Xip2F0XB4SZhKZYPl7v7EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdlN4+hO0X+uGygr58HDuWUSZwoSfLuuWwdMGKUfWsT4Q94/BYQPHQA+6iVctKYDya5tOOTkphoJr+Za1DLOP68I8vZvRieuh4dSt189EyTZCGyQkBuX+SRRBZ9IO4WtgtZ2Qg/OYU8gjiQ/s/PGyEA04qMB6IubAynVDDJ520c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfWPtj3j; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3e552eff09so508065066b.3;
        Tue, 27 Feb 2024 09:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709056105; x=1709660905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8aAOEt9j8cLf7pCbr5/djJex7kLy89KWqOPb/rg1GDY=;
        b=LfWPtj3jO3fhU2CrGf1rNgLK6vF1MsQgSDY1l6VEUo7C2bzJ4Uq4CW/ROKu3SQ/Ywg
         Uar0MKkW1dG/80vbWYHR0cYx0p8MoqFpanipNuaBSvKcnCaVJXbDPY/j8dlqMg6BtrBb
         0Zfu7eLkm8WWIn98jkoAD02Jnz5z0nhLYbcn3CJkpfA550+xNiK9A139+W/GTordmPqm
         uyx0psxauczmS7l5jtmPW9D6ISkh37FRTphEllD2kzNtcTOHqBd7eDgK25EETCDsrPAK
         0oBlu11P7U74lZzsfBZw/ZGRj0RuBMyvqF3Z33LVxnlglT1ZP1CAGap7cJltWEHtrKRq
         K0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709056105; x=1709660905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aAOEt9j8cLf7pCbr5/djJex7kLy89KWqOPb/rg1GDY=;
        b=cLJazLtQPkG0sSGs4hJc9c6WhuKiPdo9IP0zXCiXKl77oFwrxO9c01+eTfF7XRP1s0
         9XTommrHGwvXjn4ObzSIPCpkmrDW9ovIHuPtcoeU/Fk6bqDg2wYx/S9DLv7+WF1Vsbxh
         TjnCjRX8q/Y4uCRZaFHujuZo37W2OKojKbsDqm3S/zplXUEQZBQvbCpIxZ62w1CSScu/
         ZP+40zBBWV/iyh5Nqvx/+6Rv+Mb7Bi87sUdtt8P7ZBtwqRLbFRMV5/M06VjzabrV7FfR
         CoNugXKcX6YyFP4kl8mh1SaQezFYZ0J2lYyE+I/vkO8Zzfjj/Y6AH7HkvNRdJ+mCbQNu
         TNfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEl/KrS8VM2Bme3VHVwDhWU0dJgCFsuekWbuhgWPsyIiUqXLEGfjWOQqOBBDb1FE4viI0JRKoxQvtFpkSrhRHOzQlGfDEQ6fSXK4mre0L08cACwkHKbgPUKtvLiLzrXm4zGj+z0sD2jgJJAJdV/0LPmqJHUf3kDhLVQOgbD7vIF6/Kue9kxrtWEmkhrBfL+N/umkjRAu4e6YgERED3c5Q11Q==
X-Gm-Message-State: AOJu0YwF8mZFtjspvLu46fk83yZoJGc9P5mNUf9J1jDBo2A7yuZE5TaT
	DQ45IsfVjWKQyzmYkHYxPc0Uvzg2HYvmc247gdEflzGrxJ0+vWJ5zXi3bOOv8O4=
X-Google-Smtp-Source: AGHT+IEBmzlxvbwk14gM8ufAKwoOQLEW0wK/mhLD0mJLV4TBe02CEP32Gbjx1cNp3xViLTW7sq0u0Q==
X-Received: by 2002:a17:906:b847:b0:a42:e2ef:2414 with SMTP id ga7-20020a170906b84700b00a42e2ef2414mr7212089ejb.35.1709056104953;
        Tue, 27 Feb 2024 09:48:24 -0800 (PST)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id un6-20020a170907cb8600b00a3f0dbdf106sm982577ejc.105.2024.02.27.09.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 09:48:23 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Tue, 27 Feb 2024 11:48:17 -0600
From: John Groves <John@groves.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, john@jagalactic.com, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, 
	dave.hansen@linux.intel.com, gregory.price@memverge.com
Subject: Re: [RFC PATCH 09/20] famfs: Add super_operations
Message-ID: <qfxrbeajea25ckhzx74ieqg7f3baw2pqilliru4djc2a2iii6e@faxw7bgt2vi2>
References: <cover.1708709155.git.john@groves.net>
 <537f836056c141ae093c42b9623d20de919083b1.1708709155.git.john@groves.net>
 <20240226125136.00002e64@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226125136.00002e64@Huawei.com>

On 24/02/26 12:51PM, Jonathan Cameron wrote:
> On Fri, 23 Feb 2024 11:41:53 -0600
> John Groves <John@Groves.net> wrote:
> > + */
> > +static int famfs_show_options(
> > +	struct seq_file *m,
> > +	struct dentry   *root)
> Not that familiar with fs code, but this unusual kernel style. I'd go with 
> something more common
> 
> static int famfs_show_options(struct seq_file *m, struct dentry *root)

Actually, xfs does function declarations and prototypes this way, not sure if
it's everywhere. But I like this format because changing one argument usually
doesn't put un-changed args into the diff.

So I may keep this style after all.

John

