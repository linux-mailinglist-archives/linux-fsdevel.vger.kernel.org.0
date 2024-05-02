Return-Path: <linux-fsdevel+bounces-18528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DF98BA29B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 23:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72C01F24209
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 21:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3792757C96;
	Thu,  2 May 2024 21:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHHYbw3f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6199457C86;
	Thu,  2 May 2024 21:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714686692; cv=none; b=ny0TWHHkcn1s61RB2M3wFMLvhu0wuPQnigtfr8iXoHAoeR6i6uXIHLszwHLh3gDSeawg3LvS7SxqEFIkV0iYJhI9fItGml0mv48RZ2UolNPw3oc1C1byQwkavIVDpKudynXnYqeWPdPqwaO28jCFVfEp5x6lW68/em6Ff/IMlQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714686692; c=relaxed/simple;
	bh=S79CR/D0QfH8x8Go5DBVB2FXN5RusN1WZY8uz7rbrbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3UGciupB9MOACbNXfhkQ2BQaSBjuB/xKhS81Hp3C+Lvhd8uoZOEX6MQdrCCXenClxqPnTN0/5fGpfPU5koJt+2ewW4JZ02Yj5vcZokeBbRj9e7gozRtj6yqQwi75BYcR5mk5YLSeK4tyxMHQj6Bp54Ch7GwUDp8AcypnSZX9Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHHYbw3f; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ee266e2999so2900994a34.2;
        Thu, 02 May 2024 14:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714686690; x=1715291490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/L7A7dIowev4LaiY/g2BbviZcRIkjSV7hdCjyGrk3HQ=;
        b=AHHYbw3fEnsaBbjCH3GkrE3Ojx+TQRHAMqipq8CnEDSaDrVW/mdtnOub2gZfNCaOW6
         5aFXAZAimUx7FJ3i08n1h6hE/jTlzjvzupEFGdCSynzlLARwT0RRmdwRr9i715wy8lAZ
         aOSfKJ9aCTaqppc8Xw7Qr+sRtk/U1Mo4wkYI0cw3a6jTmpx/G6pEkzgMlBiYvz4zl1fo
         +4hy7QQ+9dixed49hHwVTCNSw8qMUFEXIr2rEb7WO3QS2Z3dW4urm4KX6eCWmIf++77M
         H3cfCET86BBWzint/2O2eHMOGRkB6Ir68Lu8LcqReZ2qFkCPGON7c2WLvedYOBKvKCuM
         yC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714686690; x=1715291490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/L7A7dIowev4LaiY/g2BbviZcRIkjSV7hdCjyGrk3HQ=;
        b=mPelrd1tJV5EAjO4JjVPrZLDmIKUvLpIy6zYtbncnFJL+QtP8sv9HCxmW5rHwjOPlu
         dzqE/LUjWsbm4Au4ts600l16CEOHN0gMl2NQfacAQfQ/G3bobuZjsO+nXy2sxFh07VLH
         fAhRKkac7nqymYflXBfqZmVxDb3mEppawAHWNvyqqxIFy9imUuncrNa0NGGRzMRgcwU9
         pcPDtDLUjYHJvx5QRLL2yARJiPXfEkT4u3Poz2E3I1oXp9h5UyqYSfoN1/0ly7UKFsUx
         pYwnIjufNTWRJchoiD5a2HcIzu8cYIjGxUP9Pc9OZLSf8a9sTK3IfhQwBR/2Dh0mLRRg
         D7Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVvmx0IYvYaMKetjC4F3Jt//3H6HlUKCMLcRaFHXruqs9tH85TEE+c0xzClvjfJO/s4hGzX5HOA5DwgbX6bg9RGdnEZWJzU2xKqf+HPzUPlGUKB1nXh1RFJZuXlLBjZjhwKjh3f/9KlyQ==
X-Gm-Message-State: AOJu0Yx1r1SgM3OXP6ddkbd6aY7pRL5xOM4+PRMMgfbb0QaBeQ6MOhei
	5l25uYSy9Vg7YQZJ+eTq6SyI4oaQhe2YSx+u1QF6n2KqHugV/GxB
X-Google-Smtp-Source: AGHT+IFFgIbdiVUhYAit9UXZMJJnEDO4/rfUMvDDA2e98Nw+Grxi47KMDAzShlYWDx3bPLusPCrlAw==
X-Received: by 2002:a05:6830:3493:b0:6ee:35a4:1583 with SMTP id c19-20020a056830349300b006ee35a41583mr1643807otu.30.1714686690447;
        Thu, 02 May 2024 14:51:30 -0700 (PDT)
Received: from Borg-10.local (syn-070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id f11-20020a056830264b00b006ea19aa0e4fsm357999otu.29.2024.05.02.14.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:51:29 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Thu, 2 May 2024 16:51:27 -0500
From: John Groves <John@groves.net>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	John Groves <jgroves@micron.com>, john@jagalactic.com, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com, gregory.price@memverge.com, 
	Randy Dunlap <rdunlap@infradead.org>, Jerome Glisse <jglisse@google.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	Eishan Mirakhur <emirakhur@micron.com>, Ravi Shankar <venkataravis@micron.com>, 
	Srinivasulu Thanneeru <sthanneeru@micron.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Chandan Babu R <chandanbabu@kernel.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Steve French <stfrench@microsoft.com>, 
	Nathan Lynch <nathanl@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Julien Panis <jpanis@baylibre.com>, 
	Stanislav Fomichev <sdf@google.com>, Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: Re: [RFC PATCH v2 10/12] famfs: Introduce file_operations read/write
Message-ID: <v2lja6m6hzod4iuhvhzdtu35o6xy7pf4oloq6qeck2k6ohbpn6@fsxygfwvxo5b>
References: <cover.1714409084.git.john@groves.net>
 <4584f1e26802af540a60eadb70f42c6ac5fe4679.1714409084.git.john@groves.net>
 <20240502182919.GI2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502182919.GI2118490@ZenIV>

On 24/05/02 07:29PM, Al Viro wrote:
> On Mon, Apr 29, 2024 at 12:04:26PM -0500, John Groves wrote:
> > +const struct file_operations famfs_file_operations = {
> > +	.owner             = THIS_MODULE,
> 
> Not needed, unless you are planning something really weird
> (using it for misc device, etc.)

Got it - thanks!

John


