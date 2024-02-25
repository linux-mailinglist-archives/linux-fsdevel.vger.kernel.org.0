Return-Path: <linux-fsdevel+bounces-12723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB538862BAE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 17:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17A4BB20EBC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 16:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D62517BBD;
	Sun, 25 Feb 2024 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5A6bt1y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5213717BA3
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708878220; cv=none; b=nxYZtFXbQ00W96m5caoZSTlrTeW6HXk94bNvXqs4yhzsOrzXp+tu7kbdx5vBTYcT6cJpfyHcmWL6swW1NQtsXkCLpHCoNgkYl0ZG7lxldy+WTEmG9ly1gR/7DFZEM543n9KzAFPzTLDc9X3iAsFo7l9TR20GaL1BY6pro73WguM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708878220; c=relaxed/simple;
	bh=LaigAbcADJ+dK0KzyX1kDd8eEpJpqVoPfgc/erPe1mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncnLr3UTB++hmjZ1aQqqgWwDrE+cW46SCKctF0L6ucKJfPhvfnTh1Hiw2AkdxgvHIBnpIk+y3dwTHving47ZtFh8vVVlNMbW2gsbTi3g+Da672+a/8BFQVufOIqUUVLenqddUyfMx7mi2k9McurgMETt5+33Ip3W6sAVvnLnX98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5A6bt1y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708878217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gEvjBAUJeAAT4LjTg60EE6mIK+bI32dp7aAGjL49dA4=;
	b=K5A6bt1yCs17MgxHXXR8ClkIgRcfJ6S10KqVUpdAAoroMzMaAfyU9sIiuO+99d3t0XQtNq
	fl2l4wtSkGMYrW+FU5hxX+bP75QdgJIZ0hqZ1sIsS4HQ77cLwGqrc48g20e4Bgh38TnDYa
	GFneuyYOJTXS8Po80vJXRtxOPzuZgA4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-ufnfEl6wNHea8awXFN8MGg-1; Sun, 25 Feb 2024 11:23:35 -0500
X-MC-Unique: ufnfEl6wNHea8awXFN8MGg-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5a037bd2346so2535896eaf.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 08:23:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708878214; x=1709483014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEvjBAUJeAAT4LjTg60EE6mIK+bI32dp7aAGjL49dA4=;
        b=PJ0wKpOzPH3yxA0krhE1KQZeItKTM0KET46h7sXr0xUubHp/xWTX8UgtntqgeyXgs5
         SHHIDQcoo6xOEzskZuvjIJ9ek8qJEBZvZP9vh/HARUp18PjE59hEDC9KNGyYxURJGRog
         y0UyqGKo+DNoA1y4XjKiv6boHfy/IoRRyFxAsJLdX5dvi/sH+f2Uo3i4JoX4i8Ndq62Q
         9w04u1ammg3C+0NIepH75+7SU5pnbLdmPWYNyHNc3jJmts043de+vCZtwXKBfjL4md98
         MdyzZ+WQRCevnwxpL6s9rVgR4Ywt90eTOwwDuOpTRf/39pVN8o1W+iWizaGBlOB3nubh
         hfgA==
X-Forwarded-Encrypted: i=1; AJvYcCUlg78eHQI210CT85QE3juoNMHlwXxd52sblIn90xyOfpb5B+v7KcBq+0U0J9B8hWUO0fnllnPbP2didrqeFqLdQ3YajX5sNQOnAMiyQw==
X-Gm-Message-State: AOJu0Yxh4LW0a0XfS76c8UQpOIOCcd1K3ACUUXFjDJWLnEe5AkB41yqA
	JM99lUvm+KzCIJYtcbxxwSNXaD0tA9M4dpn93tolZ6zxZpRJmexwn5nNfXkD1MO7A0H21+adwJ9
	u1xgsBTN9vFz2QaohSN5NgauFRPI9+XwoU7iXiebpfayOyVN5f1VAMmG1QJovbLc=
X-Received: by 2002:a05:6358:89f:b0:17b:6171:adab with SMTP id m31-20020a056358089f00b0017b6171adabmr6105380rwj.1.1708878214729;
        Sun, 25 Feb 2024 08:23:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLWqbRFV/lo5uRx+niwsDYaf3gj/dBLpYEFSQ6YUzFAmNj+KTGCNSHzPLbH22v7CIDVz38gA==
X-Received: by 2002:a05:6358:89f:b0:17b:6171:adab with SMTP id m31-20020a056358089f00b0017b6171adabmr6105363rwj.1.1708878214412;
        Sun, 25 Feb 2024 08:23:34 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9-20020a631d09000000b005df58c83e89sm2523823pgd.84.2024.02.25.08.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:23:34 -0800 (PST)
Date: Mon, 26 Feb 2024 00:23:29 +0800
From: Zorro Lang <zlang@redhat.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: David Disseldorp <ddiss@suse.de>, Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH fstests] common/config: fix CANON_DEVS=yes when file does
 not exist
Message-ID: <20240225162329.ax3zvbs3c3fgrqcg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240214174209.3284958-1-mcgrof@kernel.org>
 <20240215145422.2e12bb9b@echidna>
 <Zc5O07ug7e4HVmKD@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc5O07ug7e4HVmKD@bombadil.infradead.org>

On Thu, Feb 15, 2024 at 09:50:11AM -0800, Luis Chamberlain wrote:
> On Thu, Feb 15, 2024 at 02:54:22PM +1100, David Disseldorp wrote:
> > On Wed, 14 Feb 2024 09:42:08 -0800, Luis Chamberlain wrote:
> > 
> > > CANON_DEVS=yes allows you to use symlinks for devices, so fstests
> > > resolves them back to the real backind device. The iteration for
> > > resolving the backind device works obviously if you have the file
> > 
> > s/backind/backing
> 
> Zorro, can you do the minor edit?

Sure, will do that.

> 
> > > present, but if one was not present there is a parsing error. Fix
> > > this parsing error introduced by a0c36009103b8 ("fstests: add helper
> > > to canonicalize devices used to enable persistent disks").
> > > 
> > > Fixes: a0c36009103b8 ("fstests: add helper to canonicalize devices used to enable persistent disks"
> > > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > Reviewed-by: David Disseldorp <ddiss@suse.de>
> 
> Thanks!
> 
>   Luis
> 


