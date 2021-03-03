Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502BB32C54D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450710AbhCDAT7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:19:59 -0500
Received: from p3plsmtpa11-09.prod.phx3.secureserver.net ([68.178.252.110]:51141
        "EHLO p3plsmtpa11-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245634AbhCCPtc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:49:32 -0500
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id HTZMlAcQuysOoHTZNlpAJZ; Wed, 03 Mar 2021 08:37:49 -0700
X-CMAE-Analysis: v=2.4 cv=Q50XX66a c=1 sm=1 tr=0 ts=603fad4d
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=iox4zFpeAAAA:8 a=dLoG2OG8YrFFX4pwRQ8A:9 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [man-pages][PATCH v1] flock.2: add CIFS details
To:     =?UTF-8?Q?Aur=c3=a9lien_Aptel?= <aaptel@suse.com>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-man@vger.kernel.org, mtk.manpages@gmail.com
Cc:     smfrench@gmail.com
References: <20210302154831.17000-1-aaptel@suse.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <5ae02f1f-af45-25aa-71b1-4f8782286158@talpey.com>
Date:   Wed, 3 Mar 2021 10:37:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210302154831.17000-1-aaptel@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNWWA6+JBY3iBMyjGgCLKpJR3mVvXKC3n/82WsrTs31y2PEuhA2FlomIEVE5+/+Jwpm4q57KUJ0hieYlgq+s32vmvafx/MPbA0oRxpqsPKMSwYinB97+
 uoyL3jOesNNmQO5nY87ES58qDYnNclAJfgHLw+ApYJBslf1SulONvOIcnrs+7hIhfCIyKQj+goE9D9VodCgCwTZnmjKZpLce/E/jpf7Kgy5gKZIL+IP4nxtY
 csJRnmmy0If+6MmYkJURdi5x8k0siYjK3eOCcyyMI94htJdLO04V+IGEj/srt4G9LgDMQ5tHp6eCZuMcAWxT5lQsuwFQ91yZrfbQO8Yaa864e2nUinT1DtZK
 USSuzpr1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/2/2021 10:48 AM, Aurélien Aptel wrote:
> From: Aurelien Aptel <aaptel@suse.com>
> 
> Similarly to NFS, CIFS flock() locks behave differently than the
> standard. Document those differences.
> 
> Signed-off-by: Aurelien Aptel <aaptel@suse.com>
> ---
>   man2/flock.2 | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/man2/flock.2 b/man2/flock.2
> index 61d4b5396..9271b8fef 100644
> --- a/man2/flock.2
> +++ b/man2/flock.2
> @@ -239,6 +239,28 @@ see the discussion of the
>   .I "local_lock"
>   option in
>   .BR nfs (5).
> +.SS CIFS details
> +CIFS mounts share similar limitations with NFS.

I'd suggest removing this sentence. It doesn't really add anything to
the definition.

> +.PP
> +In Linux kernels up to 5.4,
> +.BR flock ()
> +locks files on the local system,
> +not over SMB. A locked file won't appear locked for other SMB clients
> +accessing the same share.

This is discussing the scenario where a process on the server performs
an flock(), right? That's perhaps confusingly special. How about

"In Linux kernels up to 5.4, flock() is not propagated over SMB. A file
with such locks will not appear locked for remote clients."

> +.PP
> +Since Linux 5.5,
> +.BR flock ()
> +are emulated with SMB byte-range locks on the
> +entire file. Similarly to NFS, this means that
> +.BR fcntl (2)
> +and
> +.BR flock ()
> +locks interact with one another over SMB. Another important
> +side-effect is that the locks are not advisory anymore: a write on a
> +locked file will always fail with
> +.BR EACCESS .
> +This difference originates from the design of locks in the SMB
> +protocol and cannot be worked around.

"protocol, which provides mandatory locking semantics."

>   .SH SEE ALSO
>   .BR flock (1),
>   .BR close (2),
> 
