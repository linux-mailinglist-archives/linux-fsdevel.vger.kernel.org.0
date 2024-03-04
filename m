Return-Path: <linux-fsdevel+bounces-13424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA7F86F99C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 06:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F8F2810CC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 05:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E4253A6;
	Mon,  4 Mar 2024 05:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vjxF6Otp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE454C64
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 05:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709530473; cv=none; b=Ixm0dFDUGTY/62p1dCNfmR4Sl2PwnS4LqZsNPaQzU95noRLgU19008XpUhgeZVTZdfggA8HXi5DkYzF3QcYcVd7KNk9tuPCpNJshzJL6OSSXbwS8XEwU+VHvggm7Nzarkvx66VI9imVA6i5JdZ39/rJ+CQiXSPYI05wQU2A78K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709530473; c=relaxed/simple;
	bh=i1SKxi1xr4fmO02OcvcqNgS+Gogn9Vcq3DXB7CeY8wY=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=o98FiMirj9zoI6ZlQHToTa9m1cqYdKiLd2lVtFZpeKYd4i3lsn07jn5/8PmfTxVWKlQ88n5uvDJJP24Ok8lGvS9Cr45ihLfXE4FeOQKo+MJC3xF1vVp/gMH5LIsyZ04JOLv+C+zd8X3WxRoI2rd45iEdOhsitTfCak8rcfxjtcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vjxF6Otp; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240304052802epoutp0136750e738a58899d72bc21ae285ef0ac~5eI2DqoCj0607106071epoutp01C
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 05:28:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240304052802epoutp0136750e738a58899d72bc21ae285ef0ac~5eI2DqoCj0607106071epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1709530082;
	bh=i1SKxi1xr4fmO02OcvcqNgS+Gogn9Vcq3DXB7CeY8wY=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=vjxF6OtpvdA/MDkbufDdTMGrDok9CM9aSfw45n/vij5qP71ehc4isP+isSKKOLDSb
	 dx3nkp9xMHTAkgP9UvKWfN/ldJt9S92L/ctFQl7fFA+jiWw86LARBkwYRhwQBpG/go
	 /JuWMM5Ks8vrp/i12XGBCjTy62nt+Zy7CT3+zne0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240304052802epcas1p1c5ec6239e0a6edd99f2750bccad70401~5eI1W1FE21232312323epcas1p1U;
	Mon,  4 Mar 2024 05:28:02 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp4.localdomain
	(Postfix) with ESMTP id 4Tp6fT6hn8z4x9QC; Mon,  4 Mar 2024 05:28:01 +0000
	(GMT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH v2 02/10] exfat: add exfat_get_empty_dentry_set() helper
Reply-To: sj1557.seo@samsung.com
Sender: =?UTF-8?B?7ISc7ISx7KKF?= <sj1557.seo@samsung.com>
From: =?UTF-8?B?7ISc7ISx7KKF?= <sj1557.seo@samsung.com>
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>, "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"Andy.Wu@sony.com" <Andy.Wu@sony.com>, "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <1891546521.01709530081906.JavaMail.epsvc@epcpadp4>
Date: Mon, 04 Mar 2024 13:43:15 +0900
X-CMS-MailID: 20240304044315epcms1p103d43bd4cfac0cdae0c17a5fd75d1527
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-ArchiveUser: EV
X-Hop-Count: 3
X-CMS-RootMailID: 20231228065938epcas1p3112d227f22639ca54849441146d9bdbf
References: <CGME20231228065938epcas1p3112d227f22639ca54849441146d9bdbf@epcms1p1>

> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < es->num_entries; i++) =
{
> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ep =3D exfat=
_get_dentry_cached(es, i);
> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ep->type=
 =3D=3D EXFAT_UNUSED)
> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0unused_hit =3D true;
> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (IS_=
EXFAT_DELETED(ep->type)) {
> >
> > Although it violates the specification for a deleted entry to follow
> > an unused entry, some exFAT implementations could work like this.
> >
> > Therefore, to improve compatibility, why don't we allow this?
> > I believe there will be no functional problem even if this is allowed.
>
> This check existed before this patch set.
Do you mean the part that will be deleted by the patch [7/10] mentioned bel=
ow?
If so, I think you may be misunderstanding it.

>
> This patch set is intended to improve the performance of sync dentry, I
> don't think it is a good idea to change other logic in this patch set.
Yeah, as you said, this patch set should keep the original logic except
for the sync related parts. The reason I left a review comment is because
the code before this patch set allows deleted dentries to follow unused
dentries.

Please let me know if I missed anything.

> Patch [7/10] moves the check from exfat_search_empty_slot() to
> exfat_validate_empty_dentry_set().
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (hint_femp->eidx !=3D EXFAT_HIN=
T_NONE &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 hint_femp->count =3D=
=3D CNT_UNUSED_HIT) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* unu=
sed empty group means
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * an =
empty group which includes
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * unu=
sed dentry
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exfat_=
fs_error(sb,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0"found bogus dentry(%d) beyond
> unused empty group(%d) (start_clu : %u, cur_clu : %u)",
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0dentry, hint_femp->eidx,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0p_dir->dir, clu.dir);
>
> >
> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (unused_hit)
> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;
> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (unused_hit)
> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;
> > Label "out" does not look like an error situation.
> > Let's use "out_err" instead of "out".
>
> Makes sense, I will rename the label to "err_deleted_after_unused".
Sounds good :)

