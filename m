Return-Path: <linux-fsdevel+bounces-27895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E790964BC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 18:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C802815DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E461B5832;
	Thu, 29 Aug 2024 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPsl7Ge3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9D61B1402;
	Thu, 29 Aug 2024 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724949282; cv=none; b=o3wuBIXcIhRTIYRIMevQWNFnvLqRZYvK65jjzSNrfCxqKDPUb5xytjTlCN5AeMRmmG1xhHCE+1EcuvFKWa+8Hz5KEpSFzIf5IAxRWz7F0pJ/XIoswE5f3X+4FlJiLpBZcjmDOSmc7KtTRwXz2lbUo9mjGTq9bsqafl17rnEIqZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724949282; c=relaxed/simple;
	bh=FUXWZyeoRfEH7SULHAyQ7rkMVwZQrMKYIJHKb9MsBaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phmNM8OFdFX6NM7ROwYe62tcoKjv0fd8jjqDALKpMecNrFWqe5hR2t/4yz2KnoIgg3wGVCGfFfMM42qTlCxDM8ZAxkdddIy/EowFH6OQxPUS7YAz/lMKsiMN5OYvpux4zlw+7NjJYNwN4rFMqgi0ZdZ4Q4zQDtw9jI2rUHvjO2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPsl7Ge3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4662FC4CEC9;
	Thu, 29 Aug 2024 16:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724949282;
	bh=FUXWZyeoRfEH7SULHAyQ7rkMVwZQrMKYIJHKb9MsBaY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vPsl7Ge3XqfWcKPkbj8bFf+fLCg78TYPqmeorfahSF5xsKILb17r9dc0YSd1B9tD2
	 F9LSu4zImkYDCzEDVjG9I9ORuoIxox1lE3of1d5a9MC6m/m4a8XQQJ1dD5mtv0q0NX
	 6aBECkw653eLDx0OVd7IdrDfLUmfvOsvssfytW4B470RRfaWu2gvigLqOAyP0dhv9E
	 0PKQo/xBrV/8MKPmgFBu1HjgEH5gszgbXc38VsIoP3Z7mGnmmYy8GD07nBrCumm9ba
	 ew76dP8hiAyNmz7cIxmGoiye52G+TA1yTUJDSvN1iI7TobgQ5v99eiwhOBLuIwuIkF
	 ORDTFXt8JZSlA==
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-82a238e0a9cso6848139f.3;
        Thu, 29 Aug 2024 09:34:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSn04eQnW+7N1vPEqMuqO2nnOMKXEzesuW5QKqpBUf4YL2Bmt2+tufr+Uy7gGxIWujQMEBWcT6tObMSKE=@vger.kernel.org, AJvYcCXHFErP9NPYwd0AsmaLxwu0jMGdJg77rpWFtW1w+PTilR+SsFgbwLO9INiGnBZC8nzERnVh3OBxwDcJ0g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdereg8XBZxepwB7OgyDqq4qjFXEWeZ0/rTqyUWVngNzKz2nwb
	eTRI8PvKjNldKw5v8iHuuTaGvYTbHbfLUc3Fp/etUL+8U83/uvLDWVgPxQW1MiKLplG/20HsvAn
	Xj3KLAx7NsFttUIQXL9lXq1AcuFA=
X-Google-Smtp-Source: AGHT+IH+a4tD5mKQJhPxlYqDFidEWy52WKxDPbeInVlr7R8p99hSBbZWs+26R6I5zpcA3p2jc4yA8xVmT213tSfRh+s=
X-Received: by 2002:a05:6e02:12c2:b0:39e:3939:5644 with SMTP id
 e9e14a558f8ab-39f3782b5f3mr45569665ab.15.1724949281600; Thu, 29 Aug 2024
 09:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829130640.1397970-1-mhocko@kernel.org>
In-Reply-To: <20240829130640.1397970-1-mhocko@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 29 Aug 2024 09:34:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4xb1BkfFHmcQtHfswHS88LH7A0+ggLt+ZFn1dpYgwr5g@mail.gmail.com>
Message-ID: <CAPhsuW4xb1BkfFHmcQtHfswHS88LH7A0+ggLt+ZFn1dpYgwr5g@mail.gmail.com>
Subject: Re: [PATCH] fs: drop GFP_NOFAIL mode from alloc_page_buffers
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 6:06=E2=80=AFAM Michal Hocko <mhocko@kernel.org> wr=
ote:
>
> From: Michal Hocko <mhocko@suse.com>
>
> There is only one called of alloc_page_buffers and it doesn't require
> __GFP_NOFAIL so drop this allocation mode.
>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Thanks for the cleanup!

I guess we will take this via the fs tree. So

Acked-by: Song Liu <song@kernel.org>

