Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA51932C56B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355135AbhCDAUi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:20:38 -0500
Received: from p3plsmtpa11-03.prod.phx3.secureserver.net ([68.178.252.104]:47639
        "EHLO p3plsmtpa11-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349230AbhCCSNf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 13:13:35 -0500
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id HVvelXiCvKEOAHVvelgCok; Wed, 03 Mar 2021 11:08:58 -0700
X-CMAE-Analysis: v=2.4 cv=erwacqlX c=1 sm=1 tr=0 ts=603fd0ba
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=iox4zFpeAAAA:8 a=Dn3fJbBJWZ8bWwpP0-sA:9 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v2] flock.2: add CIFS details
To:     =?UTF-8?Q?Aur=c3=a9lien_Aptel?= <aaptel@suse.com>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-man@vger.kernel.org, mtk.manpages@gmail.com
Cc:     smfrench@gmail.com
References: <8735xcxkv5.fsf@suse.com> <20210303163755.31127-1-aaptel@suse.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <17fc432c-f485-0945-6d12-fa338ea0025f@talpey.com>
Date:   Wed, 3 Mar 2021 13:08:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210303163755.31127-1-aaptel@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCWhMEvjwmzD8Up+kCe11ZTwxATDUaYkCaSiMu66xtAOJDknoqjgYDolWUzD30AASEU3ysNJTqgye3KgMwSCjrYbnSojIBN3xh9sSY7M38WZP//0PUlc
 e8FRucMuxT+TXlO+yOfuCEu23fHOqGS2R4OjH5gcCUvLGWoE4cYmYqgAirQTj9yWA5HbR67TSI9xsnlKEB3D34fswAlSNIJ5hI5U69AFUtGRKovTyCril6Wa
 Y3UHM4UmPcAuYKW16EqYRUUjY4UJu0sHPWNjwI0jsmdNTBn8mXAmMxAc5HRuK/mdVxqu39PAentTwAsva67FCqT4vKXZCb9zuQ6dnDsKIv0m4Jj6SDbtvhoQ
 S5y4xRm4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Definitely better! Couple of suggestions:

On 3/3/2021 11:37 AM, Aurélien Aptel wrote:
> From: Aurelien Aptel <aaptel@suse.com>
> 
> Similarly to NFS, CIFS flock() locks behave differently than the
> standard. Document those differences.
> 
> Here is the rendered text:
> 
> CIFS details
>    In  Linux kernels up to 5.4, flock() is not propagated over SMB. A file
>    with such locks will not appear locked for other SMB clients.
> 
>    Since Linux 5.5, flock() are emulated with SMB byte-range locks on  the
>    entire  file.  Similarly  to  NFS, this means that fcntl(2) and flock()
>    locks interact with one another over SMB. Another important side-effect
>    is  that  the  locks are not advisory anymore: a write on a locked file
>    will always fail with EACCESS.  This difference originates from the de-
>    sign of locks in the SMB protocol, which provides mandatory locking se-
>    mantics. The nobrl mount option can be used switch back to pre-5.5 ker-
>    nel behavior.
> 
> Signed-off-by: Aurelien Aptel <aaptel@suse.com>
> ---
>   man2/flock.2 | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/man2/flock.2 b/man2/flock.2
> index 61d4b5396..7c4e7e8c9 100644
> --- a/man2/flock.2
> +++ b/man2/flock.2
> @@ -239,6 +239,27 @@ see the discussion of the
>   .I "local_lock"
>   option in
>   .BR nfs (5).
> +.SS CIFS details
> +In Linux kernels up to 5.4,
> +.BR flock ()
> +is not propagated over SMB. A file with such locks will not appear
> +locked for other SMB clients.

Other "remote" clients, right? It's not limited to SMB, if the server
is also managing other protocols which might support flock'ing.

> +.PP
> +Since Linux 5.5,
> +.BR flock ()
> +are emulated with SMB byte-range locks on the
> +entire file. Similarly to NFS, this means that
> +.BR fcntl (2)
> +and
> +.BR flock ()
> +locks interact with one another over SMB. Another important

There's a subtlety here. If the server implements these SMB byte-range
locks in certain ways, the locks may interact with other protocols too.
So constraining the statement to "over SMB" may be incomplete.

Wy not simply say "this means that fcntl() and flock() locks interact
with one another", and preserve the generality?

> +side-effect is that the locks are not advisory anymore: a write on a
> +locked file will always fail with
> +.BR EACCESS .
> +This difference originates from the design of locks in the SMB
> +protocol, which provides mandatory locking semantics. The
> +.BR nobrl
> +mount option can be used switch back to pre-5.5 kernel behavior.

Wait, the page just said that pre-5.5 was local only. Wouldn't it
be better to just say that "nobrl" turns off the entire behavior of
forwarding locks to the server, like before? Or are there other
side effects...

Tom.

>   .SH SEE ALSO
>   .BR flock (1),
>   .BR close (2),
> 
