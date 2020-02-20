Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F448165979
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 09:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgBTIn3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 03:43:29 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36242 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgBTIn3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 03:43:29 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01K8cv00119896;
        Thu, 20 Feb 2020 08:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=3DBcmRHN7uJqFWQQFJU2jUM8me9GZcXg5MtIEEBW19g=;
 b=j4caedeSclA+wC5JW86i2YTtdgvD6z7Q21bpuXdgyugzbfmGJ6PlhDKHkjWMPTezuUyA
 4lUF0IJ01FpBja8+blyiBMv0tip0G6/yebcmWvfF8/qlY9sP4wQT5Op/tDr7ZnNR3BRH
 aKDOHjlNRAqOpdu+XN+PRUTZ3wrMr6M/aBqWq9dRfpbyLkeGRCwOeMDd7p1aH6eaIpbJ
 ytoIF6njfY/t9ju3kSgineXtxaJ0GoniyjbWzBPLiwPlx0gs7LGE0OgL5Hdem3uBeZwr
 4i+VeWEmWcVvdn8/X3/NnD0/JhjFZuaZhRCq9yqv2IcQFt4B2MhDAgWCKpTaQ+zghH1p MA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2y8udd881t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 08:43:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01K8bnNp079829;
        Thu, 20 Feb 2020 08:43:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2y8udbd8vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 08:43:12 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01K8h8m4010277;
        Thu, 20 Feb 2020 08:43:08 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Feb 2020 00:43:07 -0800
Date:   Thu, 20 Feb 2020 11:42:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v2 3/7] test_firmware: add partial read support for
 request_firmware_into_buf
Message-ID: <20200220084255.GW7838@kadam>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-4-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220004825.23372-4-scott.branden@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200064
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200064
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 04:48:21PM -0800, Scott Branden wrote:
> +static int test_dev_config_update_size_t(const char *buf,
> +					 size_t size,
> +					 size_t *cfg)
> +{
> +	int ret;
> +	long new;
> +
> +	ret = kstrtol(buf, 10, &new);
> +	if (ret)
> +		return ret;
> +
> +	if (new > SIZE_MAX)

This "new" variable is long and SIZE_MAX is ULONG_MAX so the condition
can't be true.

> +		return -EINVAL;
> +
> +	mutex_lock(&test_fw_mutex);
> +	*(size_t *)cfg = new;
> +	mutex_unlock(&test_fw_mutex);
> +
> +	/* Always return full write size even if we didn't consume all */
> +	return size;
> +}
> +
> +static ssize_t test_dev_config_show_size_t(char *buf, int cfg)
> +{
> +	size_t val;
> +
> +	mutex_lock(&test_fw_mutex);
> +	val = cfg;
> +	mutex_unlock(&test_fw_mutex);

Both val and cfg are stack variables so there is no need for locking.
Probably you meant to pass a pointer to cfg?

> +
> +	return snprintf(buf, PAGE_SIZE, "%zu\n", val);
> +}
> +
>  static ssize_t test_dev_config_show_int(char *buf, int cfg)
>  {
>  	int val;

regards,
dan carpenter


