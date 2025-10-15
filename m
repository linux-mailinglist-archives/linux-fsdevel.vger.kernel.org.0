Return-Path: <linux-fsdevel+bounces-64256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9DEBDFECF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 19:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 77376357237
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 17:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136CB2561B9;
	Wed, 15 Oct 2025 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/RcjmU6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAA31E500C;
	Wed, 15 Oct 2025 17:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760550333; cv=none; b=KOnMX+bN2MraJRkKv8ydmpQVKaS/oJn6kHnm4VavEzp4PErSg9JtZMahJQrXYt2U3Zar+e8wlpcBeehPWEYYnNTmzpk+Ti6CkJt0ve9Cr1eBQU5I+9MW4g0aI+jQpF7Gk/zbMeZjJFP5EgJF1T720aaGosJRJU5Syd9s/liELU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760550333; c=relaxed/simple;
	bh=5VHnaFTpOmXDgy5oJBc19Z3MpdZcEDhISNLaPukOCR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5WYckXPehSHCvxcobmHB8v5R6vB5pyoCKGNKxL9unfCxitBROCPBrWr9aAdHEU+8JP6ffYIYsx4KVdfeAtYaUl+8JclZUokeVl43JOw4G1fikwbixLnlIX8puHiiSzhwYY/3vjx7l3thC7OvPZihVwUkF0kztNg4V8jaUYS6zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/RcjmU6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4E7C4CEF9;
	Wed, 15 Oct 2025 17:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760550333;
	bh=5VHnaFTpOmXDgy5oJBc19Z3MpdZcEDhISNLaPukOCR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N/RcjmU6U3xHv5IG9fAqgE5OPWOpFIbVfHky25FpJ8LpZf0sj/n8MBAWJjmY2IA7B
	 H8qTdkyrCxoB5YIWqYSRJVYZ/yNMkLKjYX3B3sjDkmJQJSTxe/j6aYMZWImzVV5yPF
	 A1OjnK88AxE20+Ydhq8DRdmxsSqfVQZ8aSGyhtH3btSKu7vdjbrucVQzn6smzG5NG0
	 0PsUVhvDy/qIyUZj/ECYPzKHJ4Rg4OGT8I7ocb+WaebWlkw5GEK0c6eVJD1ZvJdkVo
	 5Op+W7Udwe4joTth8Hm8AjfUk37XsOMON87ZCHNDCL7dkzBfbzrLXsVoXoif9+XJUA
	 Rj8QJij0Ugn0A==
Date: Wed, 15 Oct 2025 10:45:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: akpm@linux-foundation.org, linux-mm <linux-mm@kvack.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: Regression in generic/749 with 8k fsblock size on 6.18-rc1
Message-ID: <20251015174532.GB6188@frogsfrogsfrogs>
References: <20251014175214.GW6188@frogsfrogsfrogs>
 <d2b367ae-b339-429b-a5e7-1d179cfa0695@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2b367ae-b339-429b-a5e7-1d179cfa0695@app.fastmail.com>

On Wed, Oct 15, 2025 at 08:39:53AM +0100, Kirill A. Shutemov wrote:
> On Tue, Oct 14, 2025, at 18:52, Darrick J. Wong wrote:
> > Did your testing also demonstrate this regression?
> 
> I have not reproduced the issue yet.
> 
> Could you check if this patch makes a difference:
> 
> https://gist.github.com/kiryl/a2c71057bec332240216cc425aca791a

Yes, it does make the test failure go away:

FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 alder-mtr00 6.18.0-rc1-xfsx #rc1 SMP PREEMPT_DYNAMIC Wed Oct 15 10:34:11 PDT 2025
MKFS_OPTIONS  -- -f -b size=8192, /dev/sdf
MOUNT_OPTIONS -- -o uquota,gquota,pquota, /dev/sdf /opt

generic/749        9s
Ran: generic/749
Passed all 1 tests

Is it valid to i_size_read() in the two places you add them?  I /think/
the folio is locked in the filemap.c hunk.  I'm not as sure about the
finish_fault changes.  If the EOF folio's locked then I think it's the
case that anything trying to change the file size will block until the
folio lock drops.

<shrug> Thanks for your help, in any case :)

--D

> -- 
> Kiryl Shutsemau / Kirill A. Shutemov
> 

