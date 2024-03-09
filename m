Return-Path: <linux-fsdevel+bounces-14041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C38876F27
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 05:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FAF1B214EE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 04:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D84364D2;
	Sat,  9 Mar 2024 04:27:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418953612D;
	Sat,  9 Mar 2024 04:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709958470; cv=none; b=gEleJ+eqx8Q4lk5hX0qJ7CR6K+WOH+uOSDLdW6agpiuSFdqVALZ6brP+6pfbK+CnaBLcwCK2I4ggQD8cZIa4y6AGymHeEJzuraJ8UJOswvhCKgfVIVS59YkPNTT/RofKv4VSv6GhgX03E5n/dlUIGYLwR74ytiB2WGyOd/6D2eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709958470; c=relaxed/simple;
	bh=s9lzqrPDk9j8gcGT1nVVajiJKR4b1xN8/LcICY6fQy4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tDiZswnmRx8k9ZFJWhC+Y8tlGOKuKCSJ4vaH47GlQBQLtYZV6z8Xi+E1rfezI5+rFpkJ1brpQV1KxAjxBp0RaA38ilHngyLospqhdgzyWDNRB57+15kOsI7fbqgCb+4RGmeCMOc+d7MvVa+sbKnza5HN0BIYq4/LYxRJL+Y/W4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ts94T1wWYz4f3l1W;
	Sat,  9 Mar 2024 12:27:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D764C1A0172;
	Sat,  9 Mar 2024 12:27:44 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgC3w5tA5etlC_4kGQ--.6806S2;
	Sat, 09 Mar 2024 12:27:44 +0800 (CST)
Subject: Re: [PATCH v2 3/6] virtiofs: factor out more common methods for
 argbuf
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>,
 "Michael S . Tsirkin" <mst@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, Benjamin Coddington <bcodding@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 houtao1@huawei.com
References: <20240228144126.2864064-1-houtao@huaweicloud.com>
 <20240228144126.2864064-4-houtao@huaweicloud.com>
 <CAJfpegsSHfO6yMpNAxaZVMvLNub_Kv5rhZQaDuJHNgHpWhpteg@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <4eed238d-f6c1-f170-797f-5b4b172b59e4@huaweicloud.com>
Date: Sat, 9 Mar 2024 12:27:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAJfpegsSHfO6yMpNAxaZVMvLNub_Kv5rhZQaDuJHNgHpWhpteg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgC3w5tA5etlC_4kGQ--.6806S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFW3Gr1fKF48XF45Zr4rGrg_yoW3AFX_uF
	Wvkry5JayUG3WfAr4kAr1agwsrCayftF109343A3929F15GFWYvF1xXryFg3Z8Xa17Ar47
	GrW3tan5trySgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
	1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	89N3UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 3/1/2024 10:24 PM, Miklos Szeredi wrote:
> On Wed, 28 Feb 2024 at 15:41, Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Factor out more common methods for bounce buffer of fuse args:
>>
>> 1) virtio_fs_argbuf_setup_sg: set-up sgs for bounce buffer
>> 2) virtio_fs_argbuf_copy_from_in_arg: copy each in-arg to bounce buffer
>> 3) virtio_fs_argbuf_out_args_offset: calc the start offset of out-arg
>> 4) virtio_fs_argbuf_copy_to_out_arg: copy bounce buffer to each out-arg
>>
>> These methods will be used to implement bounce buffer backed by
>> scattered pages which are allocated separatedly.
> Why is req->argbuf not changed to being typed?

Will update in next revision. Thanks for the suggestion.
>
> Thanks,
> Miklos


