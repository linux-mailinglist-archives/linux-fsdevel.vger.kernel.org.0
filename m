Return-Path: <linux-fsdevel+bounces-29279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33FE977936
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 09:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642FF287C07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 07:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC62777107;
	Fri, 13 Sep 2024 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ORtlmQjV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E867278289
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 07:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726211757; cv=none; b=RMsA0ZsW9eBNHztYQPBBFOOBK74LpQm4DCwt6WRaQTLopFLNQxwyWZfKcbQWC3m+fSOlWnnzLZWFO18FUB6W5oWtNjccdKmY9zxL6ZbM3nl0HPYoh6Cx4oQkkzcD2/8lrF4HUMYjZvF0huNRfk4mXo3ea6kWEd8TiLfRm5CD2wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726211757; c=relaxed/simple;
	bh=lXVe7zuMzZ3LDAaZ+Kcd6eGgm2KISOgk4k/VUcZcNTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=aZks/P4km3trqmphdVcLTPRywXfS28UrmJFq313V6WXLqUI7QsO9xTJ8nTVKvDeXbpK1qgx5TdSXuoZtuJa+LChmottO2s2OsQeYqshtZ9stQV2+vBm1HPXT7yr7NU20YG4X9UqnL1+nDH/b+Q38yKQ3gPbb77HVbZ0R1rYz6Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ORtlmQjV; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240913071552epoutp02cc5bcfc7dd4e627b54e64066f481fcc1~0vHF9o7TZ2790127901epoutp02s
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 07:15:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240913071552epoutp02cc5bcfc7dd4e627b54e64066f481fcc1~0vHF9o7TZ2790127901epoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726211752;
	bh=3zqtpJE/mdk5d0QMfgH8EkNrmbkSOpNb4bGq/RkfojY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ORtlmQjVsW2YhXgfkmG/5bxOhjsKBtoesB9TnM9kkrMggSgzuuk5thhsWSXwKcY35
	 VzH/pen3oMAEEogfXtS5X2UUN69eHuG3IQfaBtO6okL9E4pPUYr1qKo9Bm1S9llSP/
	 6NqsaFlQ/cTCVDZ3qDh//ErbKg3CYy3BWygw7ZUs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240913071552epcas5p407bc7471dba9c401717e052479b00d1a~0vHFg4og41690216902epcas5p41;
	Fri, 13 Sep 2024 07:15:52 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4X4lvq1M23z4x9Ps; Fri, 13 Sep
	2024 07:15:51 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	62.03.19863.7A6E3E66; Fri, 13 Sep 2024 16:15:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240913071550epcas5p105ccc2bbc82283e49e07d5dff05020b0~0vHEENaJk1486314863epcas5p1j;
	Fri, 13 Sep 2024 07:15:50 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240913071550epsmtrp1178989a849662704336e4812401c84a6~0vHEDG6WC1969919699epsmtrp1W;
	Fri, 13 Sep 2024 07:15:50 +0000 (GMT)
X-AuditID: b6c32a50-ef5fe70000004d97-dd-66e3e6a77a65
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	49.15.19367.6A6E3E66; Fri, 13 Sep 2024 16:15:50 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240913071547epsmtip1be43924e78b5b0a33230ca2b73f0bf33~0vHBFfCZz3168031680epsmtip1q;
	Fri, 13 Sep 2024 07:15:47 +0000 (GMT)
Message-ID: <19f3205e-ba37-0541-f8ac-4e0fc8fcee87@samsung.com>
Date: Fri, 13 Sep 2024 12:45:46 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v5 3/5] fcntl: add F_{SET/GET}_RW_HINT_EX
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	jlayton@kernel.org, chuck.lever@oracle.com
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <53043e99-be5f-4fc6-be87-4ebcb8ce99b6@acm.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xbVRTHfe+V1wdSfStj3HQG6jObDAa0E+qF8WPJ2HwRTJjoHxInPumD
	kpa26Y+xmRIJBJSp4CoO7BgwJEAh4UdBws+IZYZNIF1gbkIANyglo5AJmExEmC1lk/8+59zz
	vd9z7sklMH4JV0BkK3WsRskoKNyH0z18LCSs0bGQKRpa8YIts2U4dA6vI/Dqn5sYfDq7hMKp
	oV4Umlt+QeG1ikIU2ttMGOwoI+DCzAYXbjY0c6HReg+Bg9OhcKLuLTgweJsDaxoWufDL+z04
	bBzZQWH3Vg0GW52POdC2PeIFbaYq7qlD9OTdJNo218Ghrxp/xenJcT1taS7B6c76z+j+2g2U
	7p/Kx+m1xWkOXdrVjNBjtTe59IYlkLbYV9EUXpo8VsYyUlYjZJUZKmm2MiuOSkpNP50eJRGJ
	w8TR8E1KqGRy2DgqMTkl7Gy2wjUzJbzAKPSuVAqj1VIR8bEalV7HCmUqrS6OYtVShTpSHa5l
	crR6ZVa4ktXFiEWiE1Guwo/lss2qakxtOXCxoXvAKx9p4l1GvAlARoKaQSNyGfEh+OQAAlpn
	nnI9wToCClds2PNgsWAYeSb57ucV1HPQi4D6sbo9/SoCRueWMHcVj4wHtpkq1M0c8ggYnzfj
	nvwBcPt7O8fN/uQn4J/fqnZv9SPjwI3tJq6bMTIATNtrdrUHyXYUTBT5uA0wshwFf1daXQYE
	gZPHwJ1v9e4ab/Ik+MnRgXu0QaDwx2u7bQOy0RsMdK2jnrYTQXHfENfDfmB5pGuPBeBRWfEe
	y8GD+QccDxtAT2epl4cTQP6/v3u5fTGXb1tfhMfrJfD1lh11pwHJA18U8z3Vr4I54+KeMgA8
	rKzfYxpMl9/dbZNPLiOg+dHRbxChad+rmPZNb9o3jel/41qE04wIWLU2J4vNiFKLw5Rs7vON
	Z6hyLMjunwhJ6UFa2rfDrQhKIFYEEBh1kGfE5zP5PClz6VNWo0rX6BWs1opEufZzBRP4Z6hc
	n0qpSxdHRosiJRJJZPQbEjEVwHMWXZfyySxGx8pZVs1qnulQwluQjwp1RUV3Lt5iE6IHE62K
	98+Mhppnix76+/W+LNOwwYZzH2EZt1KPRztr8/A+Y+6Rw7phUUROtSPoftIVH19DY+YfT8aO
	RggFjC6NsoTcKxdICj+/cMY+er7aqmiSZYev2sYzidHYQEfYYY5E65TnfTVxKfOGfPL4277v
	GCqkQsNW6an+usQfkoNK+z5QhMhLXlxjix1M8qaS2xaDC6D5vcfXJWvtAXmnO1UNxFmnrZ8x
	fDgaPDSWMPVC4F+doa9Ta+fOR7WmVqIV1nfHJyfKIibMhwqSHB2vccxbg/xK37TTJ+KXCm4+
	GRqWru5sJZ98JSZ4LCg7d2ehdhl2mcZrKI5WxohDMI2W+Q+MMFVlnAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjuO+fs7GgMjjPz6x4TIxM1JeyjUqKiDhUV3a/Y1OMy51xbywqi
	lRW5Loqa1tGcpcym5GW5qamUlxJHsrykKWqoU0MtKymV0NVcgf+e931u74+XwoW9xGIqUnae
	VcjEUhHpTJhqRct9dIP9EWvNJR4ovzuBRCO1PwBK/TaFI1v3EIY6XpdjSJ//BkPpaXEYshZy
	OCpOoFB/1zgfTeny+Cippg2gqk5v1Px0B6qsaiCQVjfAR3fay0iUWz+DIdNvLY4KRsYIZJmu
	5yELl8HfvJBpad3FWHqKCSY1yUwyLY0qxpAXTzIvcq4yFVnjGFPRoSaZ7wOdBHO/JA8w77Lq
	+My4YTljsH7B9gmOO28KZ6WRF1iFX/Bp5zNTGZm43OByUWeq5KnBM4EGOFGQXgcfVI9iGuBM
	CelSAHNmynEH4Q7j2ib5DuwK9TNDfIdoBMDkni7STgjoYGjpysDsmKA9YWOf/t/eBTY8shJ2
	7EaHwspP12Y1rnQQfDL9bDYU/1vQadXO7hfQRRicbF5pL8DpFAyO3Bj71zYMYLo58e9AUSTt
	Bd8nq+wGJ3ojfDVYTDqCAqHGqAEOvALGGdPxRCDk5tzBzenj5li4OZYsQOQBN1aujJZEh8n9
	fZXiaKVKJvENi4k2gNkvWLO/DOgKp31rAEaBGgApXLRAkET2RQgF4eJLl1lFTIhCJWWVNWAJ
	RYjcBR7S+HAhLRGfZ6NYVs4q/rMY5bRYjXlfv+4nVdUZj028m/5q+rx9p+Q37eLzy/OQzZLc
	5ttwGNcdPHry6t269QMfOz9fkfO0H/X9r0cFyzCbrEp7bnPznu+8oMl7sLepaT4vzctb/rOL
	G7zSvWXD1+bYwFhzQW2f9UGtWh864cUTWRM8Yqc+7VXdydrIe9su+5BqdC048jiqY3dfC3O5
	qPdWSV117s3qbQGaipbKH8EB8yX97W/ygzJPrPZ8OFBifhySOJHNXfSf57HM1KReui1txyLz
	vvZfN75k25rGYlaNP/WxoSXD7n5jpYk7h1uvZdbnjBaJzSk9k/TEgSdFxSZj/K3bZ5/fOyUH
	5WnVloiXdzls61BhiohQnhH7r8EVSvEffHF713QDAAA=
X-CMS-MailID: 20240913071550epcas5p105ccc2bbc82283e49e07d5dff05020b0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240910151052epcas5p48b20962753b1e3171daf98f050d0b5af
References: <20240910150200.6589-1-joshi.k@samsung.com>
	<CGME20240910151052epcas5p48b20962753b1e3171daf98f050d0b5af@epcas5p4.samsung.com>
	<20240910150200.6589-4-joshi.k@samsung.com>
	<53043e99-be5f-4fc6-be87-4ebcb8ce99b6@acm.org>

On 9/13/2024 2:06 AM, Bart Van Assche wrote:
> On 9/10/24 8:01 AM, Kanchan Joshi wrote:
>> diff --git a/include/linux/rw_hint.h b/include/linux/rw_hint.h
>> index b9942f5f13d3..ff708a75e2f6 100644
>> --- a/include/linux/rw_hint.h
>> +++ b/include/linux/rw_hint.h
>> @@ -21,4 +21,17 @@ enum rw_lifetime_hint {
>>   static_assert(sizeof(enum rw_lifetime_hint) == 1);
>>   #endif
>> +#define WRITE_HINT_TYPE_BIT    BIT(7)
>> +#define WRITE_HINT_VAL_MASK    (WRITE_HINT_TYPE_BIT - 1)
>> +#define WRITE_HINT_TYPE(h)    (((h) & WRITE_HINT_TYPE_BIT) ? \
>> +                TYPE_RW_PLACEMENT_HINT : TYPE_RW_LIFETIME_HINT)
>> +#define WRITE_HINT_VAL(h)    ((h) & WRITE_HINT_VAL_MASK)
>> +
>> +#define WRITE_PLACEMENT_HINT(h)    (((h) & WRITE_HINT_TYPE_BIT) ? \
>> +                 WRITE_HINT_VAL(h) : 0)
>> +#define WRITE_LIFETIME_HINT(h)    (((h) & WRITE_HINT_TYPE_BIT) ? \
>> +                 0 : WRITE_HINT_VAL(h))
>> +
>> +#define PLACEMENT_HINT_TYPE    WRITE_HINT_TYPE_BIT
>> +#define MAX_PLACEMENT_HINT_VAL    (WRITE_HINT_VAL_MASK - 1)
>>   #endif /* _LINUX_RW_HINT_H */
> 
> The above macros implement a union of two 7-bit types in an 8-bit field.
> Wouldn't we be better of by using two separate 8-bit values such that we
> don't need the above macros?

I had considered that, but it requires two bytes of space. In inode, 
bio, and request.
For example this change in inode:

@@ -674,7 +674,13 @@ struct inode {
         spinlock_t              i_lock; /* i_blocks, i_bytes, maybe 
i_size */
         unsigned short          i_bytes;
         u8                      i_blkbits;
-       u8                      i_write_hint;
+       union {
+               struct {
+                       enum rw_liftime_hint lifetime_hint;
+                       u8 placement_hint;
+               };
+               u16 i_write_hint;
+       };

With this, generic propagation code will continue to use 
inode->i_write_hint. And specific places (that care) can use either 
lifetime_hint or placement_hint.

That kills the need of type-bit and above macros, but we don't have the 
two bytes of space currently.

