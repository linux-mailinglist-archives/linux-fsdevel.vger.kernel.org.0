Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AB5217C5D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 02:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgGHAru (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 20:47:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17972 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728184AbgGHArt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 20:47:49 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0680VUbw086164;
        Tue, 7 Jul 2020 20:47:29 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3252xwscfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 20:47:28 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0680fQqY113018;
        Tue, 7 Jul 2020 20:47:28 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3252xwscf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 20:47:28 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0680UP1Q012228;
        Wed, 8 Jul 2020 00:47:26 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 322hd7uy4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 00:47:26 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0680k2dq61211110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jul 2020 00:46:02 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAD32A4040;
        Wed,  8 Jul 2020 00:47:23 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD9E5A4051;
        Wed,  8 Jul 2020 00:47:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.200.130])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Jul 2020 00:47:20 +0000 (GMT)
Message-ID: <1594169240.23056.143.camel@linux.ibm.com>
Subject: Re: [PATCH 4/4] module: Add hook for
 security_kernel_post_read_file()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc:     Jessica Yu <jeyu@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Tue, 07 Jul 2020 20:47:20 -0400
In-Reply-To: <20200707081926.3688096-5-keescook@chromium.org>
References: <20200707081926.3688096-1-keescook@chromium.org>
         <20200707081926.3688096-5-keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_14:2020-07-07,2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 phishscore=0 cotscore=-2147483648 priorityscore=1501
 bulkscore=0 clxscore=1015 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 suspectscore=2 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007070158
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-07-07 at 01:19 -0700, Kees Cook wrote:
> Calls to security_kernel_load_data() should be paired with a call to
> security_kernel_post_read_file() with a NULL file argument. Add the
> missing call so the module contents are visible to the LSMs interested
> in measuring the module content. (This also paves the way for moving
> module signature checking out of the module core and into an LSM.)
> 
> Cc: Jessica Yu <jeyu@kernel.org>
> Fixes: c77b8cdf745d ("module: replace the existing LSM hook in init_module")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  kernel/module.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 0c6573b98c36..af9679f8e5c6 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2980,7 +2980,12 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
>  		return -EFAULT;
>  	}
>  
> -	return 0;
> +	err = security_kernel_post_read_file(NULL, (char *)info->hdr,
> +					     info->len, READING_MODULE);

There was a lot of push back on calling security_kernel_read_file()
with a NULL file descriptor here.[1]  The result was defining a new
security hook - security_kernel_load_data - and enumeration -
LOADING_MODULE.  I would prefer calling the same pre and post security
hook.

Mimi

[1] http://kernsec.org/pipermail/linux-security-module-archive/2018-Ma
y/007110.html

> +	if (err)
> +		vfree(info->hdr);
> +
> +	return err;
>  }
>  
>  static void free_copy(struct load_info *info)

