Return-Path: <linux-fsdevel+bounces-49402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D652CABBDE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 14:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1FBB7AC82F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 12:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A29527874E;
	Mon, 19 May 2025 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bo1Y0PW3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6045F278155;
	Mon, 19 May 2025 12:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747657934; cv=none; b=uj2ZYEa9P9D6P4EzOa++d4h/1ffWyt+LlcofIQ1beuq5ai3YfsGEXd60HX8V4IxcIdfrXdmtkspIte011p0k9rC9TthRk7GleDwIOhjfKbhksZadUk140Y0tq1kZ9oBqSbV87KRl2j3FvNII6Qzc2jMKn79v0+tahQeuK5354S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747657934; c=relaxed/simple;
	bh=HoUHAxsmz0lVERwzrMNPRR2kgRH7kTLlbZ6PpdDPuHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drECoXdtg2OdJfGmNdQUJID34YriZTxyf91rR8cxsnZTjizfy3vvAGUQOwuu6W8s7pXUsv+PzT+dF58A1lezkH7xybURV5wLIr3lNrJzyQsaGm1zPD89UV6dnyMzDlnc+hS3mb+WYbj885SlmX0EXgQtB4N8x85IydpbeO/OHis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bo1Y0PW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF66FC4CEF0;
	Mon, 19 May 2025 12:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747657933;
	bh=HoUHAxsmz0lVERwzrMNPRR2kgRH7kTLlbZ6PpdDPuHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bo1Y0PW3xzzj9/Nf4BKw+IflPjrSFhX3grLA1qD0eUvvIDWdbziWWlktiAY0H4THb
	 +am8I8u9EisrBdHux1//DxJ+P+8Jcwbtr5KNol/UeWaNY26ksHADBoIEfQvLV6QWPt
	 C4/XlGwHBcaEVAGtYPyYy3gNhYClTaiRUj0wM0F0=
Date: Mon, 19 May 2025 14:32:10 +0200
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
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"legion@kernel.org" <legion@kernel.org>
Subject: Re: mlock ulimits for SHM_HUGETLB
Message-ID: <2025051946-ransack-number-e5e7@gregkh>
References: <SJ2PR01MB8345DF192742AC4DB3D2CBB78E9CA@SJ2PR01MB8345.prod.exchangelabs.com>
 <SJ2PR01MB834515EA00BD7C362A77972F8E9CA@SJ2PR01MB8345.prod.exchangelabs.com>
 <2025051914-bounding-outscore-4d50@gregkh>
 <SJ2PR01MB834507D46F44F65980FE09668E9CA@SJ2PR01MB8345.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2PR01MB834507D46F44F65980FE09668E9CA@SJ2PR01MB8345.prod.exchangelabs.com>

On Mon, May 19, 2025 at 12:04:58PM +0000, Bharat Agrawal wrote:
> Thanks Greg for the response. RHEL has not been very helpful. I'm not looking to ask for patches because of the old versions.
> These messages appear in production runs, raising concerns about possible failures. Thus, the question is: Can they be ignored safely?

Again, you are paying them for support for this, please use them, there
is nothing that the community can do to help out here, sorry.

greg k-h

