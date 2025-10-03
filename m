Return-Path: <linux-fsdevel+bounces-63380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 706D0BB7546
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 17:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45D8486DE4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 15:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C432A8634F;
	Fri,  3 Oct 2025 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXsl4Bk0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F02C1E51EF;
	Fri,  3 Oct 2025 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759505660; cv=none; b=d+UzotIQf6axZdJf1wjucKNlX+Zy9v7UKTsl6mFIPiwGeUie9l2vz+FUw3IpdvOCLdtRKD1/HRhgpyGHqHfZNaW4uHBm812SEb9if9fXWwB3K/lI4fxfAe4cOMQzNQL9DZHyuHsshh8hGx3IDpA3gErzT+5uI1ZDmzi00N4jJp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759505660; c=relaxed/simple;
	bh=34Oe3kkIvVXPNFYZj3oBbSWA8hLsUlehHfqT+ggMRUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgFqRFdHhyoMi6OcXahKgfb2pHCIWUOF0IeqBCVtB4Dq8yOsbokzELljECrt7lOXtk2N+PK5xEil2VYPLgn6k0J6CtFpnIcvTjTYayPAawV01CEjXlh1pzZOSYnQckeErH5BpJkm5SSc6B5j0ozv/UymYqgOUXsiIoKJHknb04Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXsl4Bk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DB1C4CEF5;
	Fri,  3 Oct 2025 15:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759505658;
	bh=34Oe3kkIvVXPNFYZj3oBbSWA8hLsUlehHfqT+ggMRUw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CXsl4Bk0Fj5qEAD2O2MjUbvQHXgWqGzEFtWsfGMIYi1mj605pyHK3cTOms8hI5RY1
	 dt3P9gmnNyikqJBKZmUeS//EB3SWgSD7F2VEjCqEdmOfwV5Q2e7VWFJroi0KaVJsn9
	 G60G0dkZeKQCpo2QoSwFMZBq0UusGXZJYOxk+ny6kSFndooGsw2P3uZFbFmfS96HtJ
	 XDk9A3NUBgx4ptXkKubhAONaWd7rIDDTRgml1T2QCLn6Sci7pNqKsIrG4pgrqmQI9f
	 bWQ1OGbA54b+cyww9eSzImJEviiX33/AexQY6iVxuiunMF/e9HPhtuEQX9ANPa6C6p
	 G1mw6PC+6rOxA==
Message-ID: <28ffeb31-beec-4c7a-ad41-696d0fd54afe@kernel.org>
Date: Fri, 3 Oct 2025 11:34:17 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fs: Plumb case sensitivity bits into statx
To: Gabriel Krisman Bertazi <gabriel@krisman.be>,
 Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Volker Lendecke <Volker.Lendecke@sernet.de>,
 CIFS <linux-cifs@vger.kernel.org>
References: <20250925151140.57548-1-cel@kernel.org>
 <CAOQ4uxj-d87B+L+WgbFgmBQqdrYzrPStyfOKtVfcQ19bOEV6CQ@mail.gmail.com>
 <87tt0gqa8f.fsf@mailhost.krisman.be>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <87tt0gqa8f.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/3/25 11:24 AM, Gabriel Krisman Bertazi wrote:
> Amir Goldstein <amir73il@gmail.com> writes:
> 
>> On Thu, Sep 25, 2025 at 5:21 PM Chuck Lever <cel@kernel.org> wrote:

>>> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
>>> index 1686861aae20..e929b30d64b6 100644
>>> --- a/include/uapi/linux/stat.h
>>> +++ b/include/uapi/linux/stat.h
>>> @@ -219,6 +219,7 @@ struct statx {
>>>  #define STATX_SUBVOL           0x00008000U     /* Want/got stx_subvol */
>>>  #define STATX_WRITE_ATOMIC     0x00010000U     /* Want/got atomic_write_* fields */
>>>  #define STATX_DIO_READ_ALIGN   0x00020000U     /* Want/got dio read alignment info */
>>> +#define STATX_CASE_INFO                0x00040000U     /* Want/got case folding info */
>>>
>>>  #define STATX__RESERVED                0x80000000U     /* Reserved for future struct statx expansion */
>>>
>>> @@ -257,4 +258,18 @@ struct statx {
>>>  #define STATX_ATTR_WRITE_ATOMIC                0x00400000 /* File supports atomic write operations */
>>>
>>>
>>> +/*
>>> + * File system support for case folding is available via a bitmap.
>>> + */
>>> +#define STATX_CASE_PRESERVING          0x80000000 /* File name case is preserved */
>>> +
>>> +/* Values stored in the low-order byte of .case_info */
>>> +enum {
>>> +       statx_case_sensitive = 0,
>>> +       statx_case_ascii,
>>> +       statx_case_utf8,
>>> +       statx_case_utf16,
>>> +};
>>> +#define STATX_CASE_FOLDING_TYPE                0x000000ff
> 
> Does the protocol care about unicode version?  For userspace, it would
> be very relevant to expose it, as well as other details such as
> decomposition type.

For the purposes of indicating case sensitivity and preservation, the
NFS protocol does not currently care about unicode version.

But this is a very flexible proposal right now. Please recommend what
you'd like to see here. I hope I've given enough leeway that a unicode
version could be provided for other API consumers.

(As I mentioned to Jeff, there is no user space statx component in the
current proposal, but it should get one if it is agreed that's useful to
include).

-- 
Chuck Lever

