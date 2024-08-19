Return-Path: <linux-fsdevel+bounces-26241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB9095664F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 11:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2EF1F22B84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 09:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0F715B12A;
	Mon, 19 Aug 2024 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aasrhV3Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D7C15665C
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058305; cv=none; b=qH+Q/JFGjEzGe8w0ISaOT5vGeu7CdNSmcUSWBrIw0pDBmxON2bS8rsZhpYyny/nupRsW/z+dkkWH3k2QBXAJ7QNVl+nUNOrGiHlUfBaw/vp34rE6ELdaCj6vWvXPvCC/rYQpS3uRAwoycHljlPVY2AAMR4mYrjZ43tQBc1RUc8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058305; c=relaxed/simple;
	bh=CG4zU6VVFyBz4d/uvVHCRgDVKeFoaHWTns4GHuebkdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4JyBrvU1VVv4lJzMOWnQAXYvDm00dJTLcFVYfRa7c8wFTY43neOG1XJDAmdzYSbZfekl863qneU672HbHFfQLpV190wF/1+DSKOlsM8/xjkDSCbpYFA8cf1WJAIGoNYo8n7+HRuvP5yn2jWsZOR67aO1cq84Oq4oZaNT13YJPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aasrhV3Z; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bec4fc82b0so5933496a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 02:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724058302; x=1724663102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0NzoDmYOkQoanb/luOmUakch0ZsvSElM1xzRW5EirRw=;
        b=aasrhV3ZB1d+RIwF0pn2K2KQsAm7lFevikjRIUDjhuLazbvvf31c5YUDrSWFN1A+KR
         rSkc/rdwjeOIo7xoANp4jzXvizQdN6ZAjHD8Ms8/7q1cJNm0OHQbCmg4wQ5Aw95/hkri
         IjQu2G1FZJKeUfHm5DwoX+m1PSGtll43qPudKqkku7TUMBBppobAkNTySs7ZR6jtXmxH
         0jYa5y9RCEnoYDD0yhKfBhxANLikEysEHvcJQ4bt3KUt/lv69wA7nbAVglhYWu3AqypE
         e00Fyg4SFiWSe4mItLoOCTz0dD8oVTf9teu3L8IFNSrmdjAxFRG61xQji4D/qJrA7A97
         No+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724058302; x=1724663102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NzoDmYOkQoanb/luOmUakch0ZsvSElM1xzRW5EirRw=;
        b=HffITUeDBenMKD5VKrxWNRlZicHiRo/XeAP0eJOAgqfglLtXN6XgwuYyqbE7qY2Kbu
         YoDrJYXweFtjH1nM7JZLVFyvoceym11Y/pYo9UXUijlJ93ou2mKEqNcqGm8b5UfPw01c
         JmTg7bI0RfZ2LeUtFiSry0Bzsheep7reyy0ksrWHG2qeFwMQfTkHvmtloInLWGQa3wR7
         JbWRMHT8lW3b4AUrvgc/sb5ygI1z1adnQSmSjfwkAcy2akroXyLgp7J4CoBbxrspb76E
         60V0631kEcixcKMeGSRK732vSixdmHjR8xksVJ0XqiVgjYeaAewiyzTCZTTjbVYFJXyF
         wUeQ==
X-Gm-Message-State: AOJu0YxEM3kfnygYMxo+1x1zo+YnYCbd2nNjGs2492PWv2PlJpSiokwF
	pmDGPSoN8x/iH6RLu+R2D5XfSXQnt1QeHazcT3ZbmnNVg+jzr6UTx3FQ9tyqCZqa7rltFhE5+Ad
	H
X-Google-Smtp-Source: AGHT+IHdbra6QdtZPIY/wZAdx/p5FBKcHKB2xrpjaxwyM1UWh574hFBo3XlYxBFOAR4+uBMLf85Yjw==
X-Received: by 2002:a17:907:d3e8:b0:a80:c0ed:2145 with SMTP id a640c23a62f3a-a8394d6a133mr1109972866b.2.1724058302363;
        Mon, 19 Aug 2024 02:05:02 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839472f4sm606622566b.184.2024.08.19.02.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 02:05:01 -0700 (PDT)
Date: Mon, 19 Aug 2024 12:04:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] fs: Allow statmount() in foreign mount namespace
Message-ID: <041dbc14-de5f-458e-9ff2-dfb6cfad0578@stanley.mountain>
References: <e7d78aa3-a6fc-4bf8-bec2-2a672759b392@stanley.mountain>
 <20240819-episoden-erstplatzierten-6b838e8715c8@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819-episoden-erstplatzierten-6b838e8715c8@brauner>

On Mon, Aug 19, 2024 at 10:54:59AM +0200, Christian Brauner wrote:
> On Sat, Aug 17, 2024 at 08:43:41PM GMT, Dan Carpenter wrote:
> > Hello Christian Brauner,
> > 
> > Commit 71aacb4c8c3d ("fs: Allow statmount() in foreign mount
> 
> Hey Dan,
> 
> Thanks for the report.
> 
> > Should copy_mnt_id_req() ensure that kreq->mnt_ns_id is non-zero the same as
> > ->mnt_id?
> 
> No, mnt_ns_id can legitimately be zero.
> 
> > 
> >   5329          if (ret)
> >   5330                  return ret;
> >   5331  
> >   5332          ns = grab_requested_mnt_ns(&kreq);
> >   5333          if (!ns)
> >   5334                  return -ENOENT;
> > 
> > The grab_requested_mnt_ns() function returns a mix of error pointers and NULL.
> 
> I'm not sure how you got that idea. If no mnt_ns_id is specified then
> current's mnt_ns will be returned which is always valid. And if
> mnt_ns_id is specified it'll return a valid mnt_ns or NULL.

Ah.  You're right.  When ->spare is zero it can't return error pointers.  My
bad.

regards,
dan carpenter


