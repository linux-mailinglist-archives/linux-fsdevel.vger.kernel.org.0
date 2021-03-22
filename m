Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F70A343A36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 08:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCVHFx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 03:05:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36036 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhCVHFn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:05:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12M73t0o099089;
        Mon, 22 Mar 2021 07:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=x+Nl+B3JaHI2gCWqxgXVdIS2QpAmEvGC8iOFJYovRHQ=;
 b=cktZb3CwIUpnDgZQHuu0A1Wre1qxgvbjtQE/BBv3eLFw/oFjqBD2WRQDbXR39bWVaM00
 sNTab5hemCYplEpgV7khB3y3cKL56DX4kFJ+rQRRudn8jLJrn1iun4GfAejsgQq5/guF
 +rJswd3FjSBPp8lI+VnWfcbCX50JgYIR+8K6qNC8Nv9Nshb4CVFZp6zBlAShep/LO7Zu
 3SusqshZCpPtS89kdtfxnu4Tjy+oyH0mnyufdHFXHqIWIMuGM1xh6NNQoabOPG6j0hOy
 diFutFxikms3Hr4WFu+q21WGeuWDEYfEfzjqpWY4l6suRSKB8zqbhY/KezkdLhLX/Dfr 1g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 37d9pmtepg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 07:05:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12M752kW165660;
        Mon, 22 Mar 2021 07:05:03 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 37dtmmv7xb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 07:05:03 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12M750gj002777;
        Mon, 22 Mar 2021 07:05:00 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Mar 2021 00:04:59 -0700
Date:   Mon, 22 Mar 2021 10:04:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, colin.king@canonical.com,
        rdunlap@infradead.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 3/5] cifsd: add file operations
Message-ID: <20210322070447.GE1667@kadam>
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
 <CGME20210322052207epcas1p3f0a5bdfd2c994a849a67b465479d0721@epcas1p3.samsung.com>
 <20210322051344.1706-4-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322051344.1706-4-namjae.jeon@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9930 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220052
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9930 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220052
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 02:13:42PM +0900, Namjae Jeon wrote:
> +void *ksmbd_alloc(size_t size)
> +{
> +	return kvmalloc(size, GFP_KERNEL | __GFP_ZERO);


This patch adds a bunch of wrappers around kvmalloc().  Don't do that.
Just use kvmalloc() directly instead.  They just make the code hard to
read.  kvmalloc() is not appropriate for small allocations.  This
wrapper hides a GFP_KERNEL which may lead to scheduling in atomic bugs
and the secret ZEROing makes the code hard to read.

> +}
> +
> +void ksmbd_free(void *ptr)
> +{
> +	kvfree(ptr);
> +}
> +
> +static struct wm *wm_alloc(size_t sz, gfp_t flags)
> +{
> +	struct wm *wm;
> +	size_t alloc_sz = sz + sizeof(struct wm);
                          ^^^^^^^^^^^^^^^^^^^^^^

Check for integer overflow.

> +
> +	wm = kvmalloc(alloc_sz, flags);
> +	if (!wm)
> +		return NULL;
> +	wm->sz = sz;
> +	return wm;
> +}
> +
> +static int register_wm_size_class(size_t sz)
> +{
> +	struct wm_list *l, *nl;
> +
> +	nl = kvmalloc(sizeof(struct wm_list), GFP_KERNEL);

Just use kmalloc() for small allocations.

> +	if (!nl)
> +		return -ENOMEM;
> +
> +	nl->sz = sz;
> +	spin_lock_init(&nl->wm_lock);
> +	INIT_LIST_HEAD(&nl->idle_wm);
> +	INIT_LIST_HEAD(&nl->list);
> +	init_waitqueue_head(&nl->wm_wait);
> +	nl->avail_wm = 0;
> +
> +	write_lock(&wm_lists_lock);
> +	list_for_each_entry(l, &wm_lists, list) {
> +		if (l->sz == sz) {
> +			write_unlock(&wm_lists_lock);
> +			kvfree(nl);
> +			return 0;
> +		}
> +	}
> +
> +	list_add(&nl->list, &wm_lists);
> +	write_unlock(&wm_lists_lock);
> +	return 0;
> +}
> +
> +static struct wm_list *match_wm_list(size_t size)
> +{
> +	struct wm_list *l, *rl = NULL;
> +
> +	read_lock(&wm_lists_lock);
> +	list_for_each_entry(l, &wm_lists, list) {
> +		if (l->sz == size) {
> +			rl = l;
> +			break;
> +		}
> +	}
> +	read_unlock(&wm_lists_lock);
> +	return rl;
> +}
> +
> +static struct wm *find_wm(size_t size)
> +{
> +	struct wm_list *wm_list;
> +	struct wm *wm;
> +
> +	wm_list = match_wm_list(size);
> +	if (!wm_list) {
> +		if (register_wm_size_class(size))
> +			return NULL;
> +		wm_list = match_wm_list(size);
> +	}
> +
> +	if (!wm_list)
> +		return NULL;
> +
> +	while (1) {
> +		spin_lock(&wm_list->wm_lock);
> +		if (!list_empty(&wm_list->idle_wm)) {
> +			wm = list_entry(wm_list->idle_wm.next,
> +					struct wm,
> +					list);
> +			list_del(&wm->list);
> +			spin_unlock(&wm_list->wm_lock);
> +			return wm;
> +		}
> +
> +		if (wm_list->avail_wm > num_online_cpus()) {
> +			spin_unlock(&wm_list->wm_lock);
> +			wait_event(wm_list->wm_wait,
> +				   !list_empty(&wm_list->idle_wm));
> +			continue;
> +		}
> +
> +		wm_list->avail_wm++;

I don't think we should increment this until after the allocation
succeeds?

> +		spin_unlock(&wm_list->wm_lock);
> +
> +		wm = wm_alloc(size, GFP_KERNEL);
> +		if (!wm) {
> +			spin_lock(&wm_list->wm_lock);
> +			wm_list->avail_wm--;
> +			spin_unlock(&wm_list->wm_lock);
> +			wait_event(wm_list->wm_wait,
> +				   !list_empty(&wm_list->idle_wm));
> +			continue;
> +		}
> +		break;
> +	}
> +
> +	return wm;
> +}

regards,
dan carpenter

