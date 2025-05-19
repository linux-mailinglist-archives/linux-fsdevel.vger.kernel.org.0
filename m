Return-Path: <linux-fsdevel+bounces-49397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8809ABBC73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 13:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301693B9732
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA382750E3;
	Mon, 19 May 2025 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gq6O6PKY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D771420D509;
	Mon, 19 May 2025 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747654376; cv=none; b=WYl8/Q8ugQ03aEFr+fPefrsNkcm5CX4zJu4/r19S/Jh3jxEf17+fCnB581E5lMrOP5WkkadoyBUnXjG59nyiExb9axJeHu78n/Bu1vUYYk50WHfEQK24ZOt0UzxUxjL0zjH1bvXF4KMaLvusRrCQyKl9jF+MlvFt4J0tyQR2Cw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747654376; c=relaxed/simple;
	bh=aQ5zhyux3hMftcqOWcrOoFPGZ5RyMdC2sTKMO2fu8ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ+Ik5VhPHEZEJQqDucosVVnKgXILTB6UqfgDSlIndKhDTSGCEE3SypzucIEnjy3dkg5WXVB+vLO/m3NNetYGRVNOEMwbDr4KAUkrTG1nH6gkiq2XYDgpfrcNyisQUi05nttMbGewedYDXN2MIEM+bfBcg7yCwBqS5YADYnyOvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gq6O6PKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B44C4CEE4;
	Mon, 19 May 2025 11:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747654375;
	bh=aQ5zhyux3hMftcqOWcrOoFPGZ5RyMdC2sTKMO2fu8ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gq6O6PKYeAQcvV6EUmG+lkZZxnpfKbKLHxF8IJWIhFf8W1MUuxAYq2hkSXISmF6TS
	 yNfSO+CjwWMx9hMXwvqst1dmrjBO4R3ToInAwlhkmOJiB/vGpJV7Q+t3eWWJ8dzdyc
	 UTnUrapKRdE77dQN35hB/HieWx59bi7zLV+5JWZo=
Date: Mon, 19 May 2025 13:32:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Bharat Agrawal <bharat.agrawal@ansys.com>
Cc: "hughd@google.com" <hughd@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"rientjes@google.com" <rientjes@google.com>,
	"zhangyiru3@huawei.com" <zhangyiru3@huawei.com>,
	"liuzixian4@huawei.com" <liuzixian4@huawei.com>,
	"mhocko@suse.com" <mhocko@suse.com>,
	"wuxu.wu@huawei.com" <wuxu.wu@huawei.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: mlock ulimits for SHM_HUGETLB
Message-ID: <2025051914-bounding-outscore-4d50@gregkh>
References: <SJ2PR01MB8345DF192742AC4DB3D2CBB78E9CA@SJ2PR01MB8345.prod.exchangelabs.com>
 <SJ2PR01MB834515EA00BD7C362A77972F8E9CA@SJ2PR01MB8345.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ2PR01MB834515EA00BD7C362A77972F8E9CA@SJ2PR01MB8345.prod.exchangelabs.com>

On Mon, May 19, 2025 at 10:23:33AM +0000, Bharat Agrawal wrote:
> Hi all,
> 
> Could anyone please help comment on the risks associated with an application throwing the "Using mlock ulimits for SHM_HUGETLB is deprecated" message on RHEL 8.9 with 4.18.0-513.18.1.el8_9.x86_64 Linux kernel?

Why not ask RHEL support, given that you are paying them for that in
order to be using that kernel version, right?

Also note that 4.18.y is VERY old and obsolete and not supported by the
community at all.

Good luck!

greg k-h

