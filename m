Return-Path: <linux-fsdevel+bounces-59651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFF5B3BC8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 15:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A234C1C826F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 13:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095AA31A574;
	Fri, 29 Aug 2025 13:38:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2A66FC5;
	Fri, 29 Aug 2025 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756474704; cv=none; b=F2AnADvQk06NqQpbxmhV2ykPGQCRICQDR4nC4+FGfjO+eR2InOaM2UvZk8ZJAqBKXG2Tw+R2Ek1CfuBRQR/I5iOPCKgSrXxxDYBQS+DX1RZI/cvYIR6x1M7en1AXFcd0g4zspFh5U9SoWh42Tb/lDPkUPPT9l71YJk0f4Wmi/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756474704; c=relaxed/simple;
	bh=6l8qYyyo9xzbGYakuOHTAn3PdioH+JkvpoeXSqCW5NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6fS8pdL3pobg52A++o50xQl+pP5V08d0zfcGABFOEkSkIrclTcege7i6DAUVkDh1aqsMhRZXKj1oupZdO90OqFeS//ApOIKh1uwJPvcpAHeD/sRet1OGCjwtknO17xugWcQzoMZ70k7AFjdEv1N0683Yz3EPRCIwJd2G7M6Zf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 57TDbobn051412;
	Fri, 29 Aug 2025 22:37:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 57TDbnVK051401
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 29 Aug 2025 22:37:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d422acf1-129c-4886-9862-e16185ff26e9@I-love.SAKURA.ne.jp>
Date: Fri, 29 Aug 2025 22:37:47 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] vfs: exclude ntfs3 from file mode validation in
 may_open()
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Mateusz Guzik <mjguzik@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
References: <fb3888fb-11b8-481b-86a6-766bbbab5c81@I-love.SAKURA.ne.jp>
 <20250811-geteilt-sprudeln-f09e6ec25c0c@brauner>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20250811-geteilt-sprudeln-f09e6ec25c0c@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav302.rs.sakura.ne.jp
X-Virus-Status: clean

Konstantin, can you answer?

On 2025/08/11 22:50, Christian Brauner wrote:
>> Is it possible to handle this problem on the NTFS3 side?
> 
> Ugh, this is annoying.
> @Konstantin, why do you leave a zero mode for these files?
> Let's just make them regular files?
> 
>>
>>   --- a/fs/ntfs3/inode.c
>>   +++ b/fs/ntfs3/inode.c
>>   @@ -470,8 +470,9 @@ static struct inode *ntfs_read_mft(struct inode *inode,
>>           } else if (fname && fname->home.low == cpu_to_le32(MFT_REC_EXTEND) &&
>>                      fname->home.seq == cpu_to_le16(MFT_REC_EXTEND)) {
>>                   /* Records in $Extend are not a files or general directories. */
>>                   inode->i_op = &ntfs_file_inode_operations;
>>   +               mode = S_IFREG;
>>           } else {
>>                   err = -EINVAL;
>>                   goto out;
>>           }
>>
>> I don't know what breaks if we pretend as if S_IFREG...

