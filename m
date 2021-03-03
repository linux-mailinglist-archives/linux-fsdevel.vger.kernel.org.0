Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E37632C571
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355162AbhCDAUq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:20:46 -0500
Received: from p3plsmtpa11-01.prod.phx3.secureserver.net ([68.178.252.102]:42260
        "EHLO p3plsmtpa11-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1388012AbhCCUYO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 15:24:14 -0500
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id HY1ml85cHSxgqHY1mle4LS; Wed, 03 Mar 2021 13:23:27 -0700
X-CMAE-Analysis: v=2.4 cv=I6mg+Psg c=1 sm=1 tr=0 ts=603ff03f
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=SEc3moZ4AAAA:8 a=iox4zFpeAAAA:8 a=Dn3fJbBJWZ8bWwpP0-sA:9
 a=QEXdDO2ut3YA:10 a=5oRCH6oROnRZc2VpWJZ3:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v3] flock.2: add CIFS details
To:     =?UTF-8?Q?Aur=c3=a9lien_Aptel?= <aaptel@suse.com>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-man@vger.kernel.org, mtk.manpages@gmail.com
Cc:     smfrench@gmail.com
References: <17fc432c-f485-0945-6d12-fa338ea0025f@talpey.com>
 <20210303190353.31605-1-aaptel@suse.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <be8416d4-64f8-675e-3f46-f55dddf1e03b@talpey.com>
Date:   Wed, 3 Mar 2021 15:23:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210303190353.31605-1-aaptel@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAi6iph6xbnYCuduuU9qfMGGJWBIgyBcmX2RkF6vN2+w6He2BuhNBiKlSLggG+89PJmlmW2OkTfUZWnaHdsXs82nXF3EBGAUJnRG5luN8KQ1biBV6fMP
 S3HzkNICTNjCqoW7TB803VDlO+iwTnsV5X7dyf/NbWxPJezYAhQ3SQUg0Qg6CdUjeJfqfRLPYnrylKuVbzePowkKlqLpT5qITwJN+Za74xDY9Q5XNUCyYZLi
 850x9J/FbRAf9Vz/ejbblWP0fI2+aG8/7KUSUKj8WWbYZ3zLGf/jwrdFz8oNHjL43dC7qEkNXOvc6FnrW/ZVggscqXD7ORgmKHM0MWvaexJ7/b6zrZyDGaNP
 5PpRf2AQ
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It looks great, and sorry to be a pest, but I just noticed - it's
EACCES (not EACCESS).

Reviewed-By: Tom Talpey <tom@talpey.com>

On 3/3/2021 2:03 PM, Aurélien Aptel wrote:
> From: Aurelien Aptel <aaptel@suse.com>
> 
> Similarly to NFS, CIFS flock() locks behave differently than the
> standard. Document those differences.
> 
> Here is the rendered text:
> 
> CIFS details
>    In  Linux kernels up to 5.4, flock() is not propagated over SMB. A file
>    with such locks will not appear locked for remote clients.
> 
>    Since Linux 5.5, flock() locks are emulated with SMB  byte-range  locks
>    on  the  entire  file.  Similarly  to NFS, this means that fcntl(2) and
>    flock() locks interact with one another. Another important  side-effect
>    is  that  the  locks are not advisory anymore: a write on a locked file
>    will always fail with EACCESS.  This difference originates from the de-
>    sign of locks in the SMB protocol, which provides mandatory locking se-
>    mantics. The nobrl mount option (see mount.cifs(8)) turns off  fnctl(2)
>    and  flock() lock propagation to remote clients and makes flock() locks
>    advisory again.
> 
> Signed-off-by: Aurelien Aptel <aaptel@suse.com>
> ---
>   man2/flock.2 | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/man2/flock.2 b/man2/flock.2
> index 61d4b5396..4b6e5cc24 100644
> --- a/man2/flock.2
> +++ b/man2/flock.2
> @@ -239,6 +239,35 @@ see the discussion of the
>   .I "local_lock"
>   option in
>   .BR nfs (5).
> +.SS CIFS details
> +In Linux kernels up to 5.4,
> +.BR flock ()
> +is not propagated over SMB. A file with such locks will not appear
> +locked for remote clients.
> +.PP
> +Since Linux 5.5,
> +.BR flock ()
> +locks are emulated with SMB byte-range locks on the entire
> +file. Similarly to NFS, this means that
> +.BR fcntl (2)
> +and
> +.BR flock ()
> +locks interact with one another. Another important side-effect is that
> +the locks are not advisory anymore: a write on a locked file will
> +always fail with
> +.BR EACCESS .

EACCES

> +This difference originates from the design of locks in the SMB
> +protocol, which provides mandatory locking semantics. The
> +.I nobrl
> +mount option (see
> +.BR mount.cifs (8))
> +turns off
> +.BR fnctl (2)
> +and
> +.BR flock ()
> +lock propagation to remote clients and makes
> +.BR flock ()
> +locks advisory again.
>   .SH SEE ALSO
>   .BR flock (1),
>   .BR close (2),
> 
