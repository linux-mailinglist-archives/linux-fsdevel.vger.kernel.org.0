Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB94225A27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 10:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgGTIeh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 04:34:37 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:54698 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728024AbgGTIeh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:34:37 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-110-UvCh1H6SNg2kNCAjyiamHg-1; Mon, 20 Jul 2020 09:34:33 +0100
X-MC-Unique: UvCh1H6SNg2kNCAjyiamHg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 20 Jul 2020 09:34:32 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 20 Jul 2020 09:34:32 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kees Cook' <keescook@chromium.org>,
        Scott Branden <scott.branden@broadcom.com>
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 07/13] fs/kernel_read_file: Switch buffer size arg to
 size_t
Thread-Topic: [PATCH 07/13] fs/kernel_read_file: Switch buffer size arg to
 size_t
Thread-Index: AQHWXGHtmci88hmJCUOWA6z9jUdXWKkQJ6ZQ
Date:   Mon, 20 Jul 2020 08:34:32 +0000
Message-ID: <5db582d3ec08401eb4731ce3acd51561@AcuMS.aculab.com>
References: <20200717174309.1164575-1-keescook@chromium.org>
 <20200717174309.1164575-8-keescook@chromium.org>
In-Reply-To: <20200717174309.1164575-8-keescook@chromium.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kees Cook
> Sent: 17 July 2020 18:43
> In preparation for further refactoring of kernel_read_file*(), rename
> the "max_size" argument to the more accurate "buf_size", and correct
> its type to size_t. Add kerndoc to explain the specifics of how the
> arguments will be used. Note that with buf_size now size_t, it can no
> longer be negative (and was never called with a negative value). Adjust
> callers to use it as a "maximum size" when *buf is NULL.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/kernel_read_file.c            | 34 +++++++++++++++++++++++---------
>  include/linux/kernel_read_file.h |  8 ++++----
>  security/integrity/digsig.c      |  2 +-
>  security/integrity/ima/ima_fs.c  |  2 +-
>  4 files changed, 31 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
> index dc28a8def597..e21a76001fff 100644
> --- a/fs/kernel_read_file.c
> +++ b/fs/kernel_read_file.c
> @@ -5,15 +5,31 @@
>  #include <linux/security.h>
>  #include <linux/vmalloc.h>
> 
> +/**
> + * kernel_read_file() - read file contents into a kernel buffer
> + *
> + * @file	file to read from
> + * @buf		pointer to a "void *" buffer for reading into (if
> + *		*@buf is NULL, a buffer will be allocated, and
> + *		@buf_size will be ignored)
> + * @buf_size	size of buf, if already allocated. If @buf not
> + *		allocated, this is the largest size to allocate.
> + * @id		the kernel_read_file_id identifying the type of
> + *		file contents being read (for LSMs to examine)
> + *
> + * Returns number of bytes read (no single read will be bigger
> + * than INT_MAX), or negative on error.
> + *
> + */

That seems to be self-inconsistent.
If '*buf' is NULL is both says that buf_size is ignored and
is treated as a limit.
To make life easier, zero should probably be treated as no-limit.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

