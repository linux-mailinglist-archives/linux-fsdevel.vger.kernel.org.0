Return-Path: <linux-fsdevel+bounces-46164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12710A83929
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 08:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024224A014E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 06:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60471202F95;
	Thu, 10 Apr 2025 06:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="COIHO/o9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6018E18FC9D;
	Thu, 10 Apr 2025 06:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744266416; cv=none; b=TN87hPqYvwM2Deux7PzVEmAtZF0UtKY+JUd4sS6nfhewryeHbhV7Zpc0XIKBdwsmAVHI8OLGkWR9FxiIEC/hH3JhDy7oU7JBB+Syb2YzGeJDxAPO/a66pZn8glrJnIV1U1FEo5sohv9zOqyBwkl/C0p9DPrVQ3q2Gq3r8IG0v0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744266416; c=relaxed/simple;
	bh=NPC8M1VVWPm6aEQ8qWpzIuboTMn6DGJ0CqHC/ocdn2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGQEjlbIMYifqhUNAs2MTCOYoAvUmH2eCO56Fiv0bYpwdtYDXqWxPPUDPMgDcFqCAjLh3rw5OVWNgsJ9y+qBA711uLh7CSwdbFx/7hf47ETwtgJvE36Xzwn1+hhLj2Xn98hb/SV0tI/cYtEpUDGusoEyXxzEYWjLKhtsxQ5IOz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=COIHO/o9; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1744266342;
	bh=9APvfSMmJoCREHVgkcYr5TtNKHpDJ5ObAjJQ5AxzhhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=COIHO/o98/dbKUt1kSBfnw53ZysPlqNsUWobTL1GBNv3tftL9u81layW+jjbZn0oN
	 RoRnFRpfYg5kgm00cV0QZBt6IaJRMY1p+zoH16xvrBr1VvPpuNkKxfvHaQaXe/65KK
	 WerMc8mWMih8KMUH0QdufOmhr9W55rToR86F8G9k=
X-QQ-mid: bizesmtpsz5t1744266324t2f5fc6
X-QQ-Originating-IP: ul5BMEN48JfCl4FzAsJcEVJB+Z0rDjiLet/u8z/h/B4=
Received: from [10.7.13.51] ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Apr 2025 14:25:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10198454882848788505
EX-QQ-RecipientCnt: 8
Message-ID: <C11672FE2A6808C2+0da2e5a1-440e-4bd4-bf69-e9086d45ce42@uniontech.com>
Date: Thu, 10 Apr 2025 14:25:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] iomap: skip unnecessary ifs_block_is_uptodate check
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, gouhaojake@163.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, wangyuli@uniontech.com
References: <20250408172924.9349-1-gouhao@uniontech.com>
 <20250410054223.3325-1-gouhao@uniontech.com> <Z_dc-UmJs0F1UWTN@infradead.org>
From: Gou Hao <gouhao@uniontech.com>
Reply-To: Z_dc-UmJs0F1UWTN@infradead.org
In-Reply-To: <Z_dc-UmJs0F1UWTN@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: MH85Y1C9n92PGwHTmUWray1JCp2Qb9TVY8siYmYTsmZyN8vIsCK/sjZ/
	35c51xsUzHAmlJa7vQK5Dy+FPhnnLMP31pVYJQQAFgevS+JTeqddxdVdVDAcw1DNBtYRPza
	MGvNNXCHBAIxCpnExgAPpzwiwGvVPCLXxMKHcCp76sbAbzUVETYXLEouHx2Ga7bvwfppRtV
	VcUuMoER/v0IT8B3ON7cmEIcX6M7XSAtjCQNs7pukeq9VWDfudX4pFKx3d34bZiX2+Fiv25
	Tfn//5u+jmz57biFBupF5glrcyMf0DkxPBBkVMI2V81LsilcQGpMVj7XqKeP4Q0/5P3hHpv
	2wsU7Yp7RhmMp8W3LIHQfB3U5iXgCrh6GbwsU0Ke50zhFTTFvsRh31CdTIOWlXUbfqGhy0u
	6TpTvhdPvsNKDqyW7kfvLlK5lSp5QGIPvHy3XqX0ERZgUhx8mNK4H6uiaJW1Y8c0VbwrmKU
	Qix4XbwaQXHGyQ2eNftHpAcUghMzG5f9dqgXbc1leJ1fuZ26TmsNY4ErdS2+Y45R5iu/ruO
	hvpzP57i8OF0LBw5v3gqvs+DPmWWVY8ZnV1C/Kos0qAvXymbTF1IHfzX/4ON2VKX1MiRR33
	nxYiSei50DusGEv3vVVdOPfhm+4dm61e08PqufW/bLDaILcVPEx4/nMYE1f5632qy+8I6ex
	U1dyHIAEAtKD19MZJE2EqbW6fdaMZV6JCFrmXbvYYXBc4AZnmF1WRhWSquvoMY7GL0Fs+Rm
	NIJQVBvAjz1oskORBcVCRkzTjQkMnZXLfMEonkh5cT2ba5W0c47YWa3dZMesBih/8UcDJSd
	76FMs97Df/fp/DxCyef7IFRR4y8OY62ewjIJCkW6AkInmL0GPLORRsK/D2b37Yt3k5xMzAm
	cF1/Vfb2JAafAHefyjrSAAUzbjnBEU5/CjBd8kFcnoqLU2wrbfr+z7gRbQ1HFmPAqACsZi1
	3C/nE+uXcnAlFMwRLujdZnwxoOYHLrvpBl1Y6j1BCq9OCPAxxZyH1Nz3IBrM0THcWI1KfVy
	tMyTMMs3M5PapBI7Veaj6DiKlpfMVR4bCoONEiTFVUY896LrPgJB5FZG5t7Ko=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0


On 2025/4/10 13:54, Christoph Hellwig wrote:
> On Thu, Apr 10, 2025 at 01:42:23PM +0800, Gou Hao wrote:
>> prior to the loop, $i is either the first !uptodate block, or
>> it's past $last.  Assuming there's no overflow (there's no combination
>> of huge folios and tiny blksize) then yeah, there's no point in
>> retesting that the same block $i is uptodate since we hold the folio
>> lock so nobody else could have set uptodate.
> Capitalize the first word in the sentence and use up the 73 characters
> available for the commit log:
>
> In iomap_adjust_read_range, i is either the first !uptodate block, or it
> is past last for the second loop looking for trailing uptodate blocks.
> Assuming there's no overflow (there's no combination of huge folios and
> tiny blksize) then yeah, there is no point in retesting that the same
> block pointed to by i is uptodate since we hold the folio lock so nobody
> else could have set it uptodate.
Thank you, i will change the log in next patch.
>>   		/* truncate len if we find any trailing uptodate block(s) */
>> -		for ( ; i <= last; i++) {
>> +		for (i++; i <= last; i++) {
> A bit nitpicky, but I find a i++ in the initialization condition of a
> for loop a bit odd.
>
> What about turning this into a:
>
> 		while (++i <= last) {
>
> ?
Yes,  it is better.  I will test this.
>


