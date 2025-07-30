Return-Path: <linux-fsdevel+bounces-56362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF46CB168CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 00:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 648B37B2B58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 22:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726C2223DED;
	Wed, 30 Jul 2025 22:03:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B057E1FDE3D;
	Wed, 30 Jul 2025 22:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753913000; cv=none; b=J1/nXJ3K3oiubIlicSQfFt1q1TFMiZDqhWP9H81bFGuqdxYkrbLsi/6okB5M5Y/m61IUhGJEAw5u3LBGLSIGOQcn2yD339xSUBObKfJIIxNKKv0zipi85CLkMFBvJ9nztcu6bIzyabsgTucxrzJ79HlwNnFgwudrimYhtMpE51o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753913000; c=relaxed/simple;
	bh=g/N/hZ6W5cfDJAGMUWM2n2zgoKSohWbxiFAKvfP8O/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOtY226Sx//eh4x5/vtDVjZA5m+7jDJEHmugEKwj+3cuSp0Se/mc1R0SDa+JQq5Zudw10PB+5IvPD8M/iMax4RVOjnWoc4mERN/Z7mIjV/J9dAG/Mv47MYy7JOGK/0z2zHV8qro2b+G+Cwa79eaZQzyyXa/6oScSZNrcusWXxSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56UM2lZe019769;
	Thu, 31 Jul 2025 07:02:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56UM2kcl019766
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 31 Jul 2025 07:02:46 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <57d65c2f-ca35-475d-b950-8fd52b135625@I-love.SAKURA.ne.jp>
Date: Thu, 31 Jul 2025 07:02:45 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hfs: update sanity check of the root record
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "leocstone@gmail.com" <leocstone@gmail.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "willy@infradead.org" <willy@infradead.org>,
        "brauner@kernel.org" <brauner@kernel.org>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
 <65009dff-dd9d-4c99-aa53-5e87e2777017@I-love.SAKURA.ne.jp>
 <e00cff7b-3e87-4522-957f-996cb8ed5b41@I-love.SAKURA.ne.jp>
 <c99951ae12dc1f5a51b1f6c82bbf7b61b2f12e02.camel@ibm.com>
 <9a18338da59460bd5c95605d8b10f895a0b7dbb8.camel@ibm.com>
 <bb8d0438-6db4-4032-ba44-f7b4155d2cef@I-love.SAKURA.ne.jp>
 <5ef2e2838b0d07d3f05edd2a2a169e7647782de5.camel@ibm.com>
 <8cb50ca3-8ccc-461e-866c-bb322ef8bfc6@I-love.SAKURA.ne.jp>
 <d4abeee2-e291-4da4-9e0e-7880a9c213e3@I-love.SAKURA.ne.jp>
 <650d29da-4f3a-4cfe-b633-ea3b1f27de96@I-love.SAKURA.ne.jp>
 <6db77f5cb0a35de69a5b6b26719e4ffb3fdac8c5.camel@ibm.com>
 <1779f2ad-77da-40e3-9ee0-ef6c4cd468fa@I-love.SAKURA.ne.jp>
 <12de16685af71b513f8027a8bfd14bc0322eb043.camel@ibm.com>
 <0b9799d4-b938-4843-a863-8e2795d33eca@I-love.SAKURA.ne.jp>
 <427fcb57-8424-4e52-9f21-7041b2c4ae5b@I-love.SAKURA.ne.jp>
 <5498a57ea660b5366ef213acd554aba55a5804d1.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <5498a57ea660b5366ef213acd554aba55a5804d1.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav101.rs.sakura.ne.jp

On 2025/07/31 4:24, Viacheslav Dubeyko wrote:
> If we considering case HFS_CDR_DIR in hfs_read_inode(), then we know that it
> could be HFS_POR_CNID, HFS_ROOT_CNID, or >= HFS_FIRSTUSER_CNID. Do you mean that
> HFS_POR_CNID could be a problem in hfs_write_inode()?

Yes. Passing one of 1, 5 or 15 instead of 2 from hfs_fill_super() triggers BUG()
in hfs_write_inode(). We *MUST* validate at hfs_fill_super(), or hfs_read_inode()
shall have to also reject 1, 5 and 15 (and as a result only accept 2).


