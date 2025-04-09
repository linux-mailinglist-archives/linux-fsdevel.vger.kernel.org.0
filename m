Return-Path: <linux-fsdevel+bounces-46124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83688A82D92
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 19:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101D71B65232
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 17:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828A027604F;
	Wed,  9 Apr 2025 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoM8McSg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5DA270ECB;
	Wed,  9 Apr 2025 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744219639; cv=none; b=n0YiX7MpGe6gjK6RKgJIKsjaCY/nRIMNPC6EASiC99wY95nJVKKBRzXStQlJIJwMvRC+iRJnRgcx7QJuwUvyuI7dq0RCQjVXhC0S4LoWj5Fwh6V61wrXtE9Mq3dNWkfoZi6r0l5gXLro0GUez2i760uySAefuiHWqgPl9+ZSLmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744219639; c=relaxed/simple;
	bh=/Kd5Mv6OaTbwOq2qn1GDocRQ3xuHOswHjMvsZOd2mgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxNnY4bZSOjdlyCEMe8I5OidgfpFLgt5covtHrmUsa2aq+lGsopiNNsmFbXQu9p/gxWbOsZzi5D1gLbfaGnPSTU4mBPohRiSYEN1OjLfCCWDO8hF2L1i/abDwb5/+6Fu3Xz91XZyExb2MAPPAQRfCnL0XfpGZ7SPl8WclKsxEYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoM8McSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B31C4CEE2;
	Wed,  9 Apr 2025 17:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744219639;
	bh=/Kd5Mv6OaTbwOq2qn1GDocRQ3xuHOswHjMvsZOd2mgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QoM8McSgR1fXmDDbrB3h9/IRPm4sk25EC6yPN3yliCaakqnSB0/Bsji48RD2mAcMi
	 uEkTMWfGOiK4EDIZv8Muw8oiaC+YvYFo2Ozrwf74nGm0yRy4LlT2zmpa6iJALSHQvV
	 +FlK3EaEkxLVwiy2T5dNIUo6WeJvz+eaq1VW/0xTtoaJbrHlC3hzXqErZW+xfbgYDk
	 gw+HJ7aF8icq/JTxdP7HwO/f/WOcsmhYSCLJ2a0muGuRYVt0XoeijPD5yENQDWrm7M
	 //sKAJ8fgopwNU9GUHv1+c8JeavSma2/U6JrTz05Nxe7wLrpP496GcnZ1WwZ0loapP
	 0kpb0+SkVlPSw==
Date: Wed, 9 Apr 2025 10:27:16 -0700
From: Kees Cook <kees@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, John Sperbeck <jsperbeck@google.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] sysctl: Add 0012 to test the u8 range check
Message-ID: <202504091027.3A4EC8C@keescook>
References: <20250321-jag-test_extra_val-v1-0-a01b3b17dc66@kernel.org>
 <20250321-jag-test_extra_val-v1-2-a01b3b17dc66@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-jag-test_extra_val-v1-2-a01b3b17dc66@kernel.org>

On Fri, Mar 21, 2025 at 01:47:25PM +0100, Joel Granados wrote:
> Add a sysctl test that uses the new u8 test ctl files in a created by
> the sysctl test module. Check that the u8 proc file that is valid is
> created and that there are two messages in dmesg for the files that were
> out of range.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

