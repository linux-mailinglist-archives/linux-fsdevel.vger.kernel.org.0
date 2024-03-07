Return-Path: <linux-fsdevel+bounces-13957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B77B1875B40
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 00:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E82128369D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 23:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB8547F5C;
	Thu,  7 Mar 2024 23:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="g/b0Yq9O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C47EF4FC
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 23:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709855714; cv=none; b=koFcrGOJztLGNovUIy1FmQJmGLhGFGhRN1yFi6A8A6pJAYzYTVPZGxLOGz8QOqeDJ/eUfmOmaeLHGZTKnxRZ+Kn/0dsBspUxpuOPrcsnhq6xHLDkq51GCOkeIU5uTNyQ7c2JcPBht/pUUuPbC/dfgimav8b/CHuLtVxfS37WZFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709855714; c=relaxed/simple;
	bh=JWQz71f1//D9UCMTXGV7j2KbHG2h0DDPP+L3RA6F/nY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=cdd4i23aiVcK6TEI5UDYWlMQR1Boq/Q3CFHg4hCpX/KAOdlrduAln0XyeK6fXpWDNWShL7WqsRldlnKePUUNR1U69oiV1PEYinE0VO0u5UF5lLu9yxMKnk76v2izWYtS/TGGpxXR1Vq+z1yOIS+l7pVAZVIxYJrIyY+peuTmP+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=g/b0Yq9O; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240307235502epoutp047f9e301b9be93aaf79c7a5650465f962~6oLPQ-3ZZ2270722707epoutp040
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 23:55:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240307235502epoutp047f9e301b9be93aaf79c7a5650465f962~6oLPQ-3ZZ2270722707epoutp040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1709855702;
	bh=x/lMRkGh8cZSfb3n2xs7yp5rdBgxg7EAmjp1axwyya4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=g/b0Yq9Oa5EK6O3Dc06cQcWmNEB/+EHMUS/xTd3wzoR0EiRn+TsClQREmgidM5Cy4
	 /oYOeY5853m1Xrf/BInYYzRoDaabZQ7nhU1mQR9Z+B9ZeVP83bk7aXvVTuMIT4Phq9
	 uSCiYbFW4nJ6rX8OhB17qp9l14o359aZftj2N5G0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20240307235502epcas1p3664e5cdf7bd3e51bfc06a9fd66ca6f2d~6oLO_2f5U1850418504epcas1p3p;
	Thu,  7 Mar 2024 23:55:02 +0000 (GMT)
Received: from epcpadp3 (unknown [182.195.40.17]) by epsnrtp3.localdomain
	(Postfix) with ESMTP id 4TrR4Q2dj5z4x9Q8; Thu,  7 Mar 2024 23:55:02 +0000
	(GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240307110707epcas1p2b14e31d9b2efe1d187560762adbecd47~6dswePxPP1620516205epcas1p2q;
	Thu,  7 Mar 2024 11:07:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240307110707epsmtrp2a836882d3bdd7eee169f8f16700edd49~6dswdoKJb0608306083epsmtrp2Z;
	Thu,  7 Mar 2024 11:07:07 +0000 (GMT)
X-AuditID: b6c32a29-fa1ff70000002233-c2-65e99fdb3da0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	80.08.08755.BDF99E56; Thu,  7 Mar 2024 20:07:07 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240307110707epsmtip14da059ead3965ae2507244d72369c6af~6dswPVfju0927409274epsmtip1Y;
	Thu,  7 Mar 2024 11:07:07 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: <Yuezhang.Mo@sony.com>, <linkinjeon@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <Andy.Wu@sony.com>,
	<Wataru.Aoyama@sony.com>
In-Reply-To: <PUZPR04MB631617947452ADC288E8FD9281232@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v2 02/10] exfat: add exfat_get_empty_dentry_set() helper
Date: Thu, 7 Mar 2024 20:07:07 +0900
Message-ID: <664457955.21709855702359.JavaMail.epsvc@epcpadp3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQD1XOdcIp7+XJ9DfDES51wZq2IvPQHKtfRcAYc4wk4BNEtLYQK7uHResrwc2pA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSnO7t+S9TDaYtk7ZoPbKP0eLlIU2L
	idOWMlvs2XuSxWLLvyOsFh8f7Ga0uP7mIasDu8emVZ1sHn1bVjF6tE/YyezxeZNcAEsUl01K
	ak5mWWqRvl0CV8anrx+YCn6LVxw5fIGlgfECXxcjJ4eEgInEowev2LoYuTiEBHYzSnzYeIyx
	i5EDKCElcXCfJoQpLHH4cDFEyXNGiQ3TZjOB9LIJ6Eo8ufGTGcQWETCV+HL5BBuIzSwQKvHz
	zi52EFtI4DaTRMduCRCbUyBWYv7+x6wgM4UFfCTO7PAHCbMIqEjMnrqREcTmFbCUmHrlFDOE
	LShxcuYTFpByZgE9iTaIEmYBeYntb+cwQ1yvILH701FWiAv8JP696GeBqBGRmN3ZxjyBUXgW
	kkmzECbNQjJpFpKOBYwsqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgiNHS3MH4/ZV
	H/QOMTJxMB5ilOBgVhLhZbF4mSrEm5JYWZValB9fVJqTWnyIUZqDRUmcV/xFb4qQQHpiSWp2
	ampBahFMlomDU6qBSb9b2ZI9T8hxc83cziS9P8nLYn5mWH7Ye+H7tb1vqlpMoifVLMiZmDfF
	MJKnK8ptsqLxtBWBTG3iS/auabU8G6EoVe1Z3zj56s3Tz3i7eK6x5Qs+2JzX1XIg1Sj18T7f
	ru75BS7Z/+ITkhKNg9YW7vhZtkXfWudq09Jt2bdfbev+P/1i6Df70gv/WfdNqXbb2/4grPMq
	j7LJoUdVcnMET39+/2Why9Qnx3y6Z+xfqJ/04NyyLbt3OTTlNpZcXDBxe+OV+U6X9puyL07l
	ff7hcmepUUOn/yJLzjY5sY5vuVwBq1Ye/Fe51f4Wp3XyneLtNXrnU9ocS/femGt+57Zy7rPe
	mdcyt8tt9GrYOb3aRYmlOCPRUIu5qDgRAJ8wxCQLAwAA
X-CMS-MailID: 20240307110707epcas1p2b14e31d9b2efe1d187560762adbecd47
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-ArchiveUser: EV
X-Hop-Count: 3
X-CMS-RootMailID: 20231228065938epcas1p3112d227f22639ca54849441146d9bdbf
References: <CGME20231228065938epcas1p3112d227f22639ca54849441146d9bdbf@epcms1p1>
	<1891546521.01709530081906.JavaMail.epsvc@epcpadp4>
	<PUZPR04MB63166D7502785B1D91C962D181232@PUZPR04MB6316.apcprd04.prod.outlook.com>
	<1891546521.01709541901716.JavaMail.epsvc@epcpadp3>
	<PUZPR04MB631617947452ADC288E8FD9281232@PUZPR04MB6316.apcprd04.prod.outlook.com>

> Wataru.Aoyama@sony.com
> Subject: RE: [PATCH v2 02/10] exfat: add exfat_get_empty_dentry_set()
> helper
> 
> > From: Sungjong Seo <sj1557.seo@samsung.com>
> > Sent: Monday, March 4, 2024 4:43 PM
> > To: Mo, Yuezhang <Yuezhang.Mo@sony.com>; linkinjeon@kernel.org
> >
> > >
> > > The following code still exists if without this patch set. It does
> > > not allow deleted dentries to follow unused dentries.
> >
> > It may be the same part as the code you mentioned, but remember that
> > the first if-statement handles both an unused dentry and a deleted
> > dentry together.
> 
> Thanks for your detailed explanation.
> 
> I will update the code as follows, and I think it is very necessary to add
> such comments.
I think so :)

> 
>         for (i = 0; i < es->num_entries; i++) {
>                 ep = exfat_get_dentry_cached(es, i);
>                 if (ep->type == EXFAT_UNUSED)
>                         unused_hit = true;
>                 else if (IS_EXFAT_DELETED(ep->type)) {
>                         /*
>                          * Although it violates the specification for a
>                          * deleted entry to follow an unused entry, some
>                          * exFAT implementations could work like this.
>                          * Therefore, to improve compatibility, allow it.
>                          */
>                         if (unused_hit)
However, I don't think it's good idea to check for unused_hit here.
How about moving the comment at the start of the for-loop and changing
the code as follows?

/*
 * ONLY UNUSED OR DELETED DENTRIES ARE ALLOWED:
 * Although it violates the specification for a deleted entry to
 * follow an unused entry, some exFAT implementations could work
 * like this. Therefore, to improve compatibility, let's allow it.
 */
 for (i = 0; i < es->num_entries; i++) {
         ep = exfat_get_dentry_cached(es, i);
         if (ep->type == EXFAT_UNUSED) {
                 unused_hit = true;
                 continue;
         }
         if (IS_EXFAT_DELETED(ep->type))
                 continue;
         if (unused_hit)
                 goto err_used_follow_unused;
         i++;
         goto count_skip_entries;
 }

Or we could use if / else-if as follows.

for (i = 0; i < es->num_entries; i++) {
        ep = exfat_get_dentry_cached(es, i);
        if (ep->type == EXFAT_UNUSED) {
                unused_hit = true;
        } else if (!IS_EXFAT_DELETED(ep->type)) {
                if (unused_hit)
                        goto err_used_follow_unused;
                i++;
                goto count_skip_entries;
        }
}

>                                 continue;
>                 } else {
>                         /* Used entry are not allowed to follow unused
entry */
>                         if (unused_hit)
>                                 goto err_used_follow_unused;
> 
>                         i++;
>                         goto count_skip_entries;
>                 }
>         }



