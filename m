Return-Path: <linux-fsdevel+bounces-20612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DE48D60CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 13:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F0D1C23DB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 11:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A406F157A67;
	Fri, 31 May 2024 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Zo5y3Tcr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C310D8173C
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 11:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717155471; cv=none; b=LqooFBMcWG0/VpuUpdZvnriGWklY83KUqWt/r5g9kQKGNRwBq2VEnCexF7gLOQbUxc1FVflKCWnoV9x7bdkUWYb1QLNBv6t/HzVMZJp8/T6/GLMH/1J8m9ySSp97GRSR4dIFHz1z/FWQv3kqbOJ5hrqjQ1ezjXGoeoIczcnvNL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717155471; c=relaxed/simple;
	bh=5iTMpsvzMyQ/7iNgBxDn85nSx55OLExRikQYm+HZuZw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=Gz+S6RVYKtkw1YYIHmiaiHTcO2EQ8WJIt25TlG3u3peWcmf0C+70yY4o7Vc8mQVidFhasynGG8bpQvWRQq0zAsNdmZ/euzboKi1lr+094WayLY5KNiR01nO9DGnVDtl4nE/9J1pgS4Oq94HG9Lr/IhtyyY9T36vRth8wyuOyFfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Zo5y3Tcr; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240531113747epoutp03713849ba5f6b2c4da08f42f0d00ffc98~Uj8ywEw-r2985329853epoutp03O
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 11:37:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240531113747epoutp03713849ba5f6b2c4da08f42f0d00ffc98~Uj8ywEw-r2985329853epoutp03O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717155467;
	bh=GuBJyqD/FJYmGRU68Nv2DmyeEsS9lS8noNHMcJZHInE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zo5y3TcrmVBhdBVls+HHHYQ2JQckAPhmwsVEfAaUbEm79Dp/0WscpfUCE/jvqvuD7
	 NM0DbkNPwSjJ5I94T9KDlwZ/GSKo6DL1lWsnzw5839PU3h7a1UGsSAnVOu9dw9UT+/
	 F/KQTUjkgxxZ/TLQ4CvF3v7Xu1eT1YG528L0E6EI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240531113746epcas5p17564f49cdac426bcf4937b284cf1d8b0~Uj8xqSF7O2277522775epcas5p15;
	Fri, 31 May 2024 11:37:46 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VrLhS279dz4x9Pw; Fri, 31 May
	2024 11:37:44 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F6.ED.10047.886B9566; Fri, 31 May 2024 20:37:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240531102425epcas5p41ac34975c3253e5892c57c1adfd985c1~Ui8vlOYLr1813818138epcas5p4H;
	Fri, 31 May 2024 10:24:25 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240531102425epsmtrp10f664c9827b18effa1ea05ad5456a5eb~Ui8vkDLwa1379513795epsmtrp1H;
	Fri, 31 May 2024 10:24:25 +0000 (GMT)
X-AuditID: b6c32a49-1d5fa7000000273f-bb-6659b688a794
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4D.5F.08622.955A9566; Fri, 31 May 2024 19:24:25 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240531102421epsmtip279078faf44b3f9c2ecbcfc63278512ac~Ui8r7n6rH1383313833epsmtip2V;
	Fri, 31 May 2024 10:24:21 +0000 (GMT)
Date: Fri, 31 May 2024 10:17:21 +0000
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>, Mike
	Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Keith
	Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, martin.petersen@oracle.com, david@fromorbit.com,
	hare@suse.de, damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
Message-ID: <20240531101721.f3sclknsowyceszx@nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <abe8c209-d452-4fb5-90eb-f77b5ec1a2dc@acm.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA02TeVATVxzHfbubzQaHdg12fKItTBhnOIZACqSPS+votMvgHwxYa2lHSGEh
	FEgyCWhtZyw3CgoiAhJAkdIiR0GOUg6xyH05jOVoSYtSS7DIDVWLiDZhoeN/n/f9/n7v/Y55
	FC6s55tTYYooVq2QRYhIE6K+3cba/mz9JyGOOfdIVNXXhaO4i+s4Kh9PJ9FM+zJA2YurOJps
	TQZo7e4gjuq67gM08fMBVFhUQKCx1kYM3Sq6hKHS8k4M5eXEY6jz1RyJLrWNAqQf0WKoRWeH
	ricVE+hWSy+BhprySXTtez0flXS/xFDG2REMNUzGAlQ5s0CgHt0eNLjezXt/LzM07M30FUGm
	UTvOZwbvVxPM0N1opqbsHMnUFn/D/F2bC5jmsRiS+TYtk8dciJ8nmcbEBzxmSa8jmIXbIyST
	VlcGmIHCDr6PmX+4h5yVBbNqS1YRpAwOU4R6irz9Ag4FuEgdJfYSV/SeyFIhi2Q9RYeP+Nh/
	EBZhGJDI8qQsItog+cg0GpHDfg+1MjqKtZQrNVGeIlYVHKFyVok1skhNtCJUrGCj3CSOju+6
	GAIDw+X6J4NAVWv25fp5HYgBt+kUIKAg7QwTs0p4KcCEEtLNANY8SyONhpBeBrDxhg9nPDVw
	Wj9/KyO5s5rPGS0AZtW3ENxhBcDMP1M30gl6H7ysrzdEURRJ28H+V5RR3klbw6cTJRvxON1F
	wtKSi8BomNGBcK4vg2dkU/oQ7OlOwTjeAXtzJwkjC2h3mNQ6s1ErpKcEcHa8guRKOgy/q6ni
	cWwGH3fXbZZqDqfTkzb5FCy9fIPkkhMA1P6qBZxxACb2peNGxmk5/Lf1DsHpb8OsvkqM09+A
	F9YmMU43hQ1Xt9gKVlQVbhaxG44+iyWNHUOagb9XWHBTiSGgrnqcvAje0b7WkPa15zh2g+cW
	43gcW8D4H/NwreEqnN4DS15SHNrAqiaHQkCWgd2sShMZympcVBIFe+r/jQcpI2vAxgey9WoA
	4xOL4jaAUaANQAoX7TR9Hno8RGgaLDv9FatWBqijI1hNG3AxLCsDN38rSGn4gYqoAImzq6Oz
	VCp1dnWSSkS7TGcSC4KFdKgsig1nWRWr3srDKIF5DOZV4b/C3Ju1Lfto4s1fwgQmc+l2/Z7n
	m3Jyd10rW5p37yjYvmD+9XRfxD7rvH5havNe+56JgdjF5jonPzJu2HdUuvrhVH5S4oNKadfn
	KQIPicqrouDYi/m6HWM3Y4TS6Sqn3tbrHSeviLzKpw4+SQg4Q1ox+3m+mQ5JcxPBeeYvxMnb
	+b26tF5qySqw7reclIHh4RXxPzVtD2NXjzl0PM62sUt9pPl4KrRn+Qu+t5AZLi3q+OnRied/
	KK+4y090f+pXdOT00Z6QfjKz7GGXcnZb8x13t9aKhDMWshJqqGctO6b9oEpfuvqZvUdVU+9f
	R4t/yLdAjduOi31HR/z9cwNXPG4OiQiNXCaxxdUa2X/Ru+CDyQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42LZdlhJXjdyaWSawcJJ6hbrTx1jtmia8JfZ
	YvXdfjaL14c/MVpM+/CT2eLJgXZGi99nzzNbbDl2j9HiwX57iwWL5rJY3Dywk8liz6JJTBYr
	Vx9lspg9vZnJ4uj/t2wWkw5dY7R4enUWk8XeW9oWC9uWsFjs2XuSxeLyrjlsFvOXPWW3WH78
	H5PFxI6rTBY7njQyWqx7/Z7F4sQtaYvzf4+zOsh4XL7i7XFqkYTHzll32T3O39vI4nH5bKnH
	plWdbB6bl9R7vNg8k9Fj980GNo/FfZNZPXqb37F57Gy9z+rx8ektFo/3+66yefRtWcXocWbB
	EfYA4Sgum5TUnMyy1CJ9uwSujAOXVjIWHBGo2Hc7vIHxDW8XIyeHhICJRPvRjexdjFwcQgK7
	GSXat3SyQSQkJZb9PcIMYQtLrPz3nB3EFhL4yCjR9iMaxGYRUJWY8nQbUJyDg01AW+L0fw6Q
	sIiAhsS3B8tZQGYyC5xhk5jx8AQrSEJYIEHi7amJYDavgLPEieNdTBCLG1gkpvQ1sEMkBCVO
	znzCAmIzC5hJzNv8kBlkAbOAtMTyfxwQYXmJ5q2zwW7jFLCWaDvwmnUCo+AsJN2zkHTPQuie
	haR7ASPLKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4GSipbWDcc+qD3qHGJk4GA8x
	SnAwK4nw/kqPSBPiTUmsrEotyo8vKs1JLT7EKM3BoiTO++11b4qQQHpiSWp2ampBahFMlomD
	U6qBaevs3V/fc9jP8NZ+Pm1x0nszGb9p5geCufYsFCkW+zOhR/SJ1CLd14u0KgoWFgositVj
	uiPg+Dtu8/NrpWxHb05cwGglmiKmo/kn7JTFhQ9v9K/pH41fw/RAULnmfWX0Fq6ZpxPk/i1V
	2anPwBL2oNZrk9qWM0/410atcXh06Fb1/tS54Vd/212/HODt9NQm4d9U28W3/2QdsbiUvMJo
	n0HK8SKdsENNv/yEzb5VeQkk7LfZ3nJ65ZRXWy6r3znB5NO+KkNaRUxZ91tj0XaJkL4l2lsf
	G3XsLK/6yHFCkDfo8o4tkz9xvWOQl7T+lSByqFgn9u9Bxu4Dz61E9X8U+irv8LOtm/DtafSX
	uccT1JRYijMSDbWYi4oTAfUGRciVAwAA
X-CMS-MailID: 20240531102425epcas5p41ac34975c3253e5892c57c1adfd985c1
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----4kURd6qQA_jt7Hem8gQqXiu1-FVD8qSeML2_RvQot6TDP4ZY=_48084_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102842epcas5p4949334c2587a15b8adab2c913daa622f
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
	<20240520102033.9361-3-nj.shetty@samsung.com>
	<eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org>
	<20240529061736.rubnzwkkavgsgmie@nj.shetty@samsung.com>
	<9f1ec1c1-e1b8-48ac-b7ff-8efb806a1bc8@kernel.org>
	<a866d5b5-5b01-44a2-9ccb-63bf30aa8a51@acm.org>
	<665850bd.050a0220.a5e6b.5b72SMTPIN_ADDED_BROKEN@mx.google.com>
	<abe8c209-d452-4fb5-90eb-f77b5ec1a2dc@acm.org>

------4kURd6qQA_jt7Hem8gQqXiu1-FVD8qSeML2_RvQot6TDP4ZY=_48084_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 30/05/24 10:11AM, Bart Van Assche wrote:
>On 5/30/24 00:16, Nitesh Shetty wrote:
>>+static inline bool blk_copy_offload_attempt_combine(struct request_queue *q,
>>+                         struct bio *bio)
>>+{
>>+    struct blk_plug *plug = current->plug;
>>+    struct request *rq;
>>+
>>+    if (!plug || rq_list_empty(plug->mq_list))
>>+        return false;
>>+
>>+    rq_list_for_each(&plug->mq_list, rq) {
>>+        if (rq->q == q) {
>>+            if (!blk_copy_offload_combine(rq, bio))
>>+                return true;
>>+            break;
>>+        }
>>+
>>+        /*
>>+         * Only keep iterating plug list for combines if we have multiple
>>+         * queues
>>+         */
>>+        if (!plug->multiple_queues)
>>+            break;
>>+    }
>>+    return false;
>>+}
>
>This new approach has the following two disadvantages:
>* Without plug, REQ_OP_COPY_SRC and REQ_OP_COPY_DST are not combined. These two
>  operation types are the only operation types for which not using a plug causes
>  an I/O failure.
>* A loop is required to combine the REQ_OP_COPY_SRC and REQ_OP_COPY_DST operations.
>
>Please switch to the approach Hannes suggested, namely bio chaining. Chaining
>REQ_OP_COPY_SRC and REQ_OP_COPY_DST bios before these are submitted eliminates the
>two disadvantages mentioned above.
>
Bart, Hannes,

I see the following challenges with bio-chained approach.
1. partitioned device:
	We need to add the code which iterates over all bios and adjusts
	the sectors offsets.
2. dm/stacked device:
	We need to make major changes in dm, such as allocating cloned
	bios, IO splits, IO offset mappings. All of which need to
	iterate over chained BIOs.

Overall with chained BIOs we need to add a special handling only for copy
to iterate over chained BIOs and do the same thing which is being done
for single BIO at present.
Or am I missing something here ?

Thank You,
Nitesh Shetty

------4kURd6qQA_jt7Hem8gQqXiu1-FVD8qSeML2_RvQot6TDP4ZY=_48084_
Content-Type: text/plain; charset="utf-8"


------4kURd6qQA_jt7Hem8gQqXiu1-FVD8qSeML2_RvQot6TDP4ZY=_48084_--

