Return-Path: <linux-fsdevel+bounces-2962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D9F7EE496
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 16:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93F27B20AE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 15:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F3734551;
	Thu, 16 Nov 2023 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from p3plwbeout16-02.prod.phx3.secureserver.net (p3plsmtp16-02-2.prod.phx3.secureserver.net [173.201.193.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D06E19E
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 07:48:03 -0800 (PST)
X-MW-NODE: 
X-CMAE-Analysis: v=2.4 cv=SYYyytdu c=1 sm=1 tr=0 ts=655639b2
 a=dFffxkGDbYo3ckkjzRcKYg==:117 a=dFffxkGDbYo3ckkjzRcKYg==:17
 a=TT3OXX8_H1iH7GK2:21 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=t7CeM3EgAAAA:8
 a=FXvPX3liAAAA:8 a=hSkVLCK3AAAA:8 a=hlfSdipmgW7WWFGKQN0A:9 a=QEXdDO2ut3YA:10
 a=EebzJV9D4rpJJoWO5PQE:22 a=FdTzh2GWekK77mhwV6Dw:22 a=UObqyxdv-6Yh2QiB9mM_:22
 a=cQPPKAXgyycSBL8etih5:22 a=b0R6z3OkPTeaBGj_aaBY:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
X-SID: 3eb2rPcI9GN7i
Date: Thu, 16 Nov 2023 15:47:59 +0000 (GMT)
From: Phillip Lougher <phillip@squashfs.org.uk>
To: Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+32d3767580a1ea339a81@syzkaller.appspotmail.com,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	squashfs-devel@lists.sourceforge.net,
	syzkaller-bugs@googlegroups.com
Message-ID: <261429818.1734406.1700149679974@eu1.myprofessionalmail.com>
In-Reply-To: <20231116031352.40853-1-lizhi.xu@windriver.com>
References: <0000000000000526f2060a30a085@google.com>
 <20231116031352.40853-1-lizhi.xu@windriver.com>
Subject: Re: [PATCH] squashfs: squashfs_read_data need to check if the
 length is 0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.18.49
X-Originating-IP: 82.69.79.175
X-Originating-Client: open-xchange-appsuite
X-CMAE-Envelope: MS4xfP5dWoFg+M+ZbHqU6VfYXdfwfo2GWM4bkl/BocaMV3PJM36+tJnayLaj5N+fOY/wfJtaAqSRbDzYoK4RvQBifMSoZXLM5ZW8UGrGj7gJ4TqUNX+EXXji
 Y+x2GdNvPOiSAkVqTy/8r7vRcMjYjJMN5uSagylNF1qNQ38kzHI6WKOkvpCTlJz+j6A1tnd0qtQl7EMmrodQHNEytKXfEkiaYP3S3mGZnE77Tvp+7Kds8ORe
 JvIbZmaKwKUyt5hvGMfnvz17XtHuCFProE9plCbX6enG5Fa1Uk2NJfDJdJwjoOli6FQM19zC0ZQFeJR3/VKL0jCk7L1drGh+tLH0Uadq7+0UFh0GvewPUM+2
 gh5wtf6jf6mAbVpZw/VMmGtCBlFHZWZDp6kqOepZj977Wh1eLhZ52TB1uTboFJP0UIMT15TPmG4RV7E2SV0nzMhKHA+wsaWR5675kyeWfsaOnBXzV/EuEMX8
 gGQAGF8S3HNEg7m6n6EaNYcc6qzDTRajc9JboBEUdLnbA7r3ELq4TmqMoaNq3Ukuuwfsb0lmZvbNdXzM


> On 16/11/2023 03:13 GMT Lizhi Xu <lizhi.xu@windriver.com> wrote:
> 
>  
> when the length passed in is 0, the subsequent process should be exited.
> 

Reproduced and tested.

Reviewed-by: Phillip Lougher (phillip@squashfs.org.uk)

> Reported-by: syzbot+32d3767580a1ea339a81@syzkaller.appspotmail.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>  fs/squashfs/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
> index 581ce9519339..2dc730800f44 100644
> --- a/fs/squashfs/block.c
> +++ b/fs/squashfs/block.c
> @@ -321,7 +321,7 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
>  		TRACE("Block @ 0x%llx, %scompressed size %d\n", index - 2,
>  		      compressed ? "" : "un", length);
>  	}
> -	if (length < 0 || length > output->length ||
> +	if (length <= 0 || length > output->length ||
>  			(index + length) > msblk->bytes_used) {
>  		res = -EIO;
>  		goto out;
> -- 
> 2.25.1

