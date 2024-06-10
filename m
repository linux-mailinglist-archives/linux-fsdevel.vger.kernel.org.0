Return-Path: <linux-fsdevel+bounces-21331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8147F9020B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 13:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884311C214CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 11:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182647E103;
	Mon, 10 Jun 2024 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRzX4RoS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B327C6D4
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2024 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020251; cv=none; b=cWTEOodCblDpOfjcIBy0V0qwR7AeM0rvdFlbK6NZkHSPRK1Ae9yDkCQhKDuiW3WIfZWnP/KET5S0QO7PoEzc6Z05/m4k6x2+D1aDe9GgYS/+IeutUe9WVw+Z0zJXHx6IIH1B9ucZRBajhzGVR+ABvubrRPl7SZnoyHh4LgVQJ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020251; c=relaxed/simple;
	bh=OjN/CiuX2/qTHwbr4CU1naB3gMqMQKb8jczVnH4WXT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOG9UYptLD3lBBDqfO4Pf/w7uwZz7TKif22oSAd02LWf8TlU8SO2o7UhyI9QQwOlsfKW+seLq377cEnJgHZCru7dPxxAkJfl0E8odJat5SArqGmMIf8a56BuMiIuFnrGBt6Esa1zZYNNP5FlAml+bnskmblUTg14wFb9lA7R0vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WRzX4RoS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718020248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lkcZ4eVGTT54I19uoqqELFijbSYZMUBCzhmuStsLApw=;
	b=WRzX4RoS0ZfCj0sr+0NsALkWGaWXDRxIkJvUAv0SZFH3AjYjrcGFeV1rdFOl7l01pPeesL
	QAeB9WnyDBaXE4qPKLsjJA9XN5LPJJsOtis3tM51K2J9fS2jNK4Cy5q6RZiQIAW3eAUCWv
	d5j39a7lcsvRC9dmkyYN9FTAw5Yl18U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-IDOHp_uDP3q6nhfvjLHz0w-1; Mon, 10 Jun 2024 07:50:45 -0400
X-MC-Unique: IDOHp_uDP3q6nhfvjLHz0w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42108822a8eso27745425e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2024 04:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718020244; x=1718625044;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lkcZ4eVGTT54I19uoqqELFijbSYZMUBCzhmuStsLApw=;
        b=Mg6S96zmzu+L35OsfdMpEgcjYSLW2QtUM2LC1Nv4akfud0qleQ1qLcZqcKGAQIZT6w
         fx4mVz3hMBpnmx+TmuW8DtEQ5ExVf/lYbG/q6Y7D0OKjLbpbP1s1g8dONt8y1qbyVGYl
         4HzXJ2ozv9WtR2dI84Y1C2021SqTxMVGHHC2zcUP/9LpPzOC/aiSNeAJoeQJcziccEWX
         CSeMSeGm8NLs05mSAmwgIZHr5jWlJWHjg3pReRobn69+jZfH+proxzM/YsoyHGBTZ0LL
         ukFyInz7Bh3l7AHcoWDF8tB1/X0Y3I/wuqv7BuTM5Ks93tWuUUcNnx0sJpn/7x2wDHFo
         rhnw==
X-Forwarded-Encrypted: i=1; AJvYcCViMMaGs8jLHey/+nu2BCAKlPL9e8WDgRnjjWBheAwtNm3c3Mia+H37JL7Wp87yTk0Gjqppwpulz7g+eJ7yXaMFJ2X4kHFbd+8rOYBC1g==
X-Gm-Message-State: AOJu0YzLdJR6yKKff9ILfqiMEmoIB4lVca73y5BjfIYkeolhe3lUgolC
	HjirFJZWmvAqVXHol8COmu19W7Q39rGZSpvJBHZMj182N/JpXk+t2FCU60RwwSZvqOzznFHLuwK
	GAxBe7ax03El1ii9RZN0Arux5EEsX3/i2sT71e/m0b5Na58Kuxcb7yinPsp1zMA==
X-Received: by 2002:adf:cd0c:0:b0:35f:1f66:d708 with SMTP id ffacd0b85a97d-35f1f66d867mr4241509f8f.22.1718020243824;
        Mon, 10 Jun 2024 04:50:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4H6tXGPxHG1UFZSn7T+5ZheNe+pIpBTt220ay0XOChYi4OycjL3JvSdeTGE0tdsOdUh55JQ==
X-Received: by 2002:adf:cd0c:0:b0:35f:1f66:d708 with SMTP id ffacd0b85a97d-35f1f66d867mr4241481f8f.22.1718020243252;
        Mon, 10 Jun 2024 04:50:43 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35efa97b15dsm9825493f8f.81.2024.06.10.04.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 04:50:42 -0700 (PDT)
Date: Mon, 10 Jun 2024 13:50:42 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: Re: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and
 FS_IOC_FSGETXATTRAT
Message-ID: <kh5z3o4wj2mxx45cx3v2p6osbgn5bd2sdexksmwio5ad5biiru@wglky7rxvj6l>
References: <20240531145204.GJ52987@frogsfrogsfrogs>
 <20240603104259.gii7lfz2fg7lyrcw@quack3>
 <vbiskxttukwzhjoiic6toscqc6b2qekuwumfpzqp5vkxf6l6ia@pby5fjhlobrb>
 <20240603174259.GB52987@frogsfrogsfrogs>
 <20240604085843.q6qtmtitgefioj5m@quack3>
 <20240605003756.GH52987@frogsfrogsfrogs>
 <CAOQ4uxiVVL+9DEn9iJuWRixVNFKJchJHBB8otH8PjuC+j8ii4g@mail.gmail.com>
 <ZmEemh4++vMEwLNg@dread.disaster.area>
 <tnj5nqca7ewg5igfvhwhmjigpg3nxeic4pdqecac3azjsvcdev@plebr5ozlvmb>
 <CAOQ4uxg6qihDRS1c11KUrrANrxJ2XvFUtC2gHY0Bf3TQjS0y4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxg6qihDRS1c11KUrrANrxJ2XvFUtC2gHY0Bf3TQjS0y4A@mail.gmail.com>

On 2024-06-10 12:19:50, Amir Goldstein wrote:
> On Mon, Jun 10, 2024 at 11:17 AM Andrey Albershteyn <aalbersh@redhat.com> wrote:
> >
> > On 2024-06-06 12:27:38, Dave Chinner wrote:
> ...
> > >
> > > The only reason XFS returns -EXDEV to rename across project IDs is
> > > because nobody wanted to spend the time to work out how to do the
> > > quota accounting of the metadata changed in the rename operation
> > > accurately. So for that rare case (not something that would happen
> > > on the NAS product) we returned -EXDEV to trigger the mv command to
> > > copy the file to the destination and then unlink the source instead,
> > > thereby handling all the quota accounting correctly.
> > >
> > > IOWs, this whole "-EXDEV on rename across parent project quota
> > > boundaries" is an implementation detail and nothing more.
> > > Filesystems that implement project quotas and the directory tree
> > > sub-variant don't need to behave like this if they can accurately
> > > account for the quota ID changes during an atomic rename operation.
> > > If that's too hard, then the fallback is to return -EXDEV and let
> > > userspace do it the slow way which will always acocunt the resource
> > > usage correctly to the individual projects.
> > >
> > > Hence I think we should just fix the XFS kernel behaviour to do the
> > > right thing in this special file case rather than return -EXDEV and
> > > then forget about the rest of it.
> >
> > I see, I will look into that, this should solve the original issue.
> 
> I see that you already got Darrick's RVB on the original patch:
> https://lore.kernel.org/linux-xfs/20240315024826.GA1927156@frogsfrogsfrogs/
> 
> What is missing then?
> A similar patch for rename() that allows rename of zero projid special
> file as long as (target_dp->i_projid == src_dp->i_projid)?
> 
> In theory, it would have been nice to fix the zero projid during the
> above link() and rename() operations, but it would be more challenging
> and I see no reason to do that if all the other files remain with zero
> projid after initial project setup (i.e. if not implementing the syscalls).

I think Dave suggests to get rid of this if-guard and allow
link()/rename() for special files but with correct quota calculation.

> 
> >
> > But those special file's inodes still will not be accounted by the
> > quota during initial project setup (xfs_quota will skip them), would
> > it worth it adding new syscalls anyway?
> >
> 
> Is it worth it to you?
> 
> Adding those new syscalls means adding tests and documentation
> and handle all the bugs later.
> 
> If nobody cared about accounting of special files inodes so far,
> there is no proof that anyone will care that you put in all this work.

I already have patch and some simple man-pages prepared, I'm
wondering if this would be useful for any other usecases which would
require setting extended attributes on spec indodes.

> 
> Thanks,
> Amir.
> 

-- 
- Andrey


