Return-Path: <linux-fsdevel+bounces-13027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DBC86A4BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 02:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF5F1C2402B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 01:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBBD1FB3;
	Wed, 28 Feb 2024 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMY6CVTD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD0FEBF;
	Wed, 28 Feb 2024 01:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709082374; cv=none; b=tuRXd5m6FGv5Vbo2KuDD4Qpy0qMTUe+aBqtfA90+4nT0XSAYuknQ5Lcs+SPAnG8LEZ0hoXD82pfUU0NLrY7AFhEz02ArJ4OvMPka9cxpsIoZjzbvpu1Tm/HC6K/kecUoK5GeKfhbtSTJhjZrqLLlOreRpU3ZkpgZ9jmDA80h6sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709082374; c=relaxed/simple;
	bh=Sm75gcCv9xKtIq0Ia+ywMl1YZw2dek62rJr+oQKTC1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjU7IsNrefAwEcKZu4AKTe6gYJrnZ0ACGQd62WGCGsU9yHXfmN7lzcMZ6HrcheDdZxS10bOJ9oQm52ZWwR41HyxCKHTwuhe+QIXzACDuwb5gKlJrjo4kyUGTGATmsIhpF52vIZX/Ndu2OhV/anyRBjMOKYKKAlP5f3Mllqo54oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMY6CVTD; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e49872f576so1656005a34.1;
        Tue, 27 Feb 2024 17:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709082372; x=1709687172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DhG2DGa6pDHH1VG928nucKPhUiyDvmB5uJFD8WxCLAk=;
        b=eMY6CVTD1mZfy03rOZkJ4ki/QIeX53Mx2oiVe2EPjFaYG+lPUv/D05iyiotwDXcLxx
         pfSoxsDvJ6Vz6gWEfEj0nlD4hKz/78j6xWas7xXV0t5qOnb34AahB49xjZslFbS7ev3f
         EuWPAK7Ah4wohBdaYAO1s1PmIuoyH69zYYoWcMXgcOIvRXuFsReyHSDFNpZ5Xg6W7lQG
         WdpJiBv2G+ySuQSQUNWljKnI2M55f9HKo8e2nLiO2qxxNLrd5ujcFOrRe4Hko4B44GBI
         gYcKlp9UO/sr7nKIY3cTjNvPw+RzCX5H5NFLdMTnUpHjdjgUH8IFFRCeYgDgDpwABFKb
         uX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709082372; x=1709687172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhG2DGa6pDHH1VG928nucKPhUiyDvmB5uJFD8WxCLAk=;
        b=hpmeQp1E3u3ObK7fli9lVTrrf++q1OocXyMRjwOB2IQ4P5mjUCccoV0+FECIKsMfXZ
         dC3MUxPtZ9rNgk2HKlkRfwX2x2vhgkP0CfdIHQuI078TZkVafALz7TeL6fecPXydTUwu
         qXiUAumrqoaT5Md2Ap1kW9Z0zNFQkwXYfdH9ZGjCHPr1EPypbC78+yQbxH8EklbHzmd4
         Itpo1CBf2P0Q53fMimFgLppwUG7TMIgrJYsP/SXYKlvHwy+wYC3tmTMeKZPSmCnS5bDI
         RzEffwSVuOQ/eFMnbYQdNucGuLxWQqmi2xe+q/kgAXhzAzI9MQ1JlfkauPV4vVcHRZsM
         CbEw==
X-Forwarded-Encrypted: i=1; AJvYcCXHmMS+0ZFqhOoxRUkh1NRHhQqc0xVp5vJLuBBH1w1u4dy0Thunx9cnCIWJfcoRRDhpjJFz5yIhxNeRJxLiAm46Wc+U0FCZjoSKupS+inKuREo9NSwKE0TBVQ/voqEsaKdXaA+739Wz8s1wUp57xiHbZ32ECXmflxmyaUHS2taDBcYVH8nZXyPm+E1DVg6eGOjy+S6FSGRnyqr2BpLY7OKKzg==
X-Gm-Message-State: AOJu0Ywj/p8Yq0KjGKESJdBygDWKMxL2dw1X/DJuji3b99/UTiBNGLzn
	hjf+N74+y17B/YRR4E9GJSMe3F7FlcHKIvcO/qKGzM+X5297HTLn
X-Google-Smtp-Source: AGHT+IFKfO0y13JodeF6eFlc6IWCbbbk2Jvw3nQLEBpJsjWeW7+WZ/Ry4CGjgxNXq0G9thCXP1TIMA==
X-Received: by 2002:a9d:6a9a:0:b0:6e4:8d2d:64e5 with SMTP id l26-20020a9d6a9a000000b006e48d2d64e5mr11096665otq.13.1709082372064;
        Tue, 27 Feb 2024 17:06:12 -0800 (PST)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id p4-20020a056830338400b006e2d8b5d9e5sm1713834ott.21.2024.02.27.17.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 17:06:11 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Tue, 27 Feb 2024 19:06:09 -0600
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
Subject: Re: [RFC PATCH 08/20] famfs: Add famfs_internal.h
Message-ID: <agvghv2lask3iazxtycynwkdydrxqula3pwbrusvwn3e2fz6jd@nrmpnbamp6f7>
References: <cover.1708709155.git.john@groves.net>
 <13556dbbd8d0f51bc31e3bdec796283fe85c6baf.1708709155.git.john@groves.net>
 <20240226124818.0000251d@Huawei.com>
 <u6nfwlidsmmhejsboqdo4r2juox4txkzt4ffjlnlcqzzrwthlt@wsh5eb5xeghj>
 <20240227102846.00003eef@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227102846.00003eef@Huawei.com>

On 24/02/27 10:28AM, Jonathan Cameron wrote:
> On Mon, 26 Feb 2024 11:35:17 -0600
> John Groves <John@groves.net> wrote:
> 
> > On 24/02/26 12:48PM, Jonathan Cameron wrote:
> > > On Fri, 23 Feb 2024 11:41:52 -0600
> > > John Groves <John@Groves.net> wrote:
> > >   
> > > > Add the famfs_internal.h include file. This contains internal data
> > > > structures such as the per-file metadata structure (famfs_file_meta)
> > > > and extent formats.
> > > > 
> > > > Signed-off-by: John Groves <john@groves.net>  
> > > Hi John,
> > > 
> > > Build this up as you add the definitions in later patches.
> > > 
> > > Separate header patches just make people jump back and forth when trying
> > > to review.  Obviously more work to build this stuff up cleanly but
> > > it's worth doing to save review time.
> > >   
> > 
> > Ohhhhkaaaaay. I think you're right, just not looking forward to
> > all that rebasing.
> 
> :)  Patch mangling is half the fun of upstream development :)
> 
> > 
> > > Generally I'd plumb up Kconfig and Makefile a the beginning as it means
> > > that the set is bisectable and we can check the logic of building each stage.
> > > That is harder to do but tends to bring benefits in forcing clear step
> > > wise approach on a patch set. Feel free to ignore this one though as it
> > > can slow things down.  
> > 
> > I'm not sure that's practical. A file system needs a bunch of different
> > kinds of operations
> > - super_operations
> > - fs_context_operations
> > - inode_operations
> > - file_operations
> > - dax holder_operations, iomap_ops
> > - etc.
> > 
> > Will think about the dependency graph of these entities, but I'm not sure
> > it's tractable...
> 
> Sure.  There's a difference though between doing something useful (or
> even successfully loading) and being able to build it at intermediate steps.
> I'm only looking for buildability.
> 
> If not possible, even with a few stubs, empty ops structures etc
> then fair enough.
> 
> Jonathan

I'm through at least the first stage of grief on this. By the time we're
through this I'll be able to reconstitute the whole bloody thing from memory,
backwards :D

John


