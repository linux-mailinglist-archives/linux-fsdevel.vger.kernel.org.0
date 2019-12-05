Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E03A7114302
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 15:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfLEOvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 09:51:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47745 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729489AbfLEOvO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575557473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=39Vx1E3J2trELSrcI4/o4ODhF+EVYsemFf+4VPkk/+k=;
        b=idL9RNPwLjQEBGh/4zqCGbOi5+T/8qkmFaoScW0v2/OthfT4TPZJPypwGulMRVKVq4NQZK
        9qrjSKTs99gWBkkV+aTZ6/622zEo/B/WCCEi3E4YNbA2Gh68zM1hkZDozyOf8S4AS4uhE4
        mHgrhsLVBSf6ARU17nbNlhFb0+LhgP4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-3B2fmY2sPaOw_SbImavqoA-1; Thu, 05 Dec 2019 09:51:09 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACF29800EB9;
        Thu,  5 Dec 2019 14:51:07 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-205-135.brq.redhat.com [10.40.205.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AEF619C7F;
        Thu,  5 Dec 2019 14:51:04 +0000 (UTC)
Date:   Thu, 5 Dec 2019 15:51:02 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] libblkid: implement zone-aware probing for HMZONED btrfs
Message-ID: <20191205145102.omyoq6nn5qnximxr@10.255.255.10>
References: <20191204082513.857320-1-naohiro.aota@wdc.com>
 <20191204083023.861495-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
In-Reply-To: <20191204083023.861495-1-naohiro.aota@wdc.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 3B2fmY2sPaOw_SbImavqoA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 04, 2019 at 05:30:23PM +0900, Naohiro Aota wrote:
>  =09while(mag && mag->magic) {
>  =09=09unsigned char *buf;
> -
> -=09=09off =3D (mag->kboff + (mag->sboff >> 10)) << 10;
> +=09=09uint64_t kboff;
> +
> +=09=09if (!mag->is_zone)
> +=09=09=09kboff =3D mag->kboff;
> +=09=09else {
> +=09=09=09uint32_t zone_size_sector;
> +=09=09=09int ret;
> +
> +=09=09=09ret =3D ioctl(pr->fd, BLKGETZONESZ, &zone_size_sector);

I guess this ioctl returns always the same number, right?=20

If yes, than you don't want to call it always when libmount compares
any magic string. It would be better call it only once from
blkid_probe_set_device() and save zone_size_sector to struct
blkid_probe.

    Karel

--=20
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

