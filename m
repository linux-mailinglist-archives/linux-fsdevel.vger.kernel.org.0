Return-Path: <linux-fsdevel+bounces-47544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D7DA9FCC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 00:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4132B464E01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 22:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C472210F4B;
	Mon, 28 Apr 2025 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLsi/6iT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF8A210184
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 22:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745878217; cv=none; b=IpK6Ztk2CN941sVRLIDGsIGZI/uMlj0PmVsB50n72Eun1b8P+Xu8qEIb1zeHQkt+08RVaw+EW/+2pyQ3cjme4VWzxbwSHvfZkoQQaSid2SlK6XeNtAo2zqfIkUDB3Se0eEOxJgTPMd/TmznUdm96TnB410z2zAsYzQGuzZ3gpFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745878217; c=relaxed/simple;
	bh=uIzPWoRnQgetoFt6qUJlH+8oIS0aGCriUQItkH/OtvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZR5SYjh36RynrnFlfxtJwMsidCfcLDG4Y4P8WqJReRXv6gJIhOSSj3nJTgTX4gez57EE2yngRdnoYb3r3DQCgIx2gXaVgSyImkGpiL9cVnh0dacBdkTfUYAPQS/dA2tseZdDD/m2a55+Bz7VM9mYUBDFtrPbyYjwtotjJAdc3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLsi/6iT; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c5568355ffso492418785a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 15:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745878214; x=1746483014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G68A8gbIzA2mqZ+V7TIqI4HzTFE3WV0mnGFlPr8YtK8=;
        b=dLsi/6iT6BrWwRb6LM3bZxf7bqIqoeu3KZrCxXkKzbgrxomEiAmUVdNDWtv60UghxL
         jbsML2qf9JSjh9Jn0qZj2Rii1oDhFRYuSkV9TAuWuW6U/IlG/a63MvZ/iS5tjSQsqWlE
         sesn0tIutTtMjB9zOI3XQOPtVK5p+cHoQn822a/JwszoaxM/IoKF6Np3A82QgriLjp5J
         CkIkkMEvWL+/4T6anyh6gNfSQBJv+TRevhXw2hjbD74OqcrNqaU4p9Perdav+4POoI7N
         WhIz2L/qBOF90gSQfKgku5gplUCcHpwQJz4TSGzHi5bS1EhTITHJibHZIMyyphWe32YP
         9wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745878214; x=1746483014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G68A8gbIzA2mqZ+V7TIqI4HzTFE3WV0mnGFlPr8YtK8=;
        b=BDXxDRm0sjtjeabaO7Hz6vfo481zQh59eyiTv0htvQriT8wUNwciYuVyx6Y0S8ITbh
         hcKTlVAHKc4OIBs+TkHIGTERrO8+3CikGU+K0gIglkKQTogjMPlcD/PRgsvWh/tEs1Ky
         4Os8Rrl6bKgi6icwgp02EDy/EcBnMQW9N2Pbxv8PMljMrdnQG5OaXzDaC4HDLVSSPiAZ
         OuuyewVk5qX+XvDn0QJOVCZVbmqHaXyggIj7MX4XLmQsWw5UhQwF4J9xUdDNfDnijRKl
         wWb9m2XDGnmmAONkgOED3wy4upFCyTvtdJcFMEwoMfMxdEmZs0bcytJILZnIm2QocEpy
         MSOA==
X-Forwarded-Encrypted: i=1; AJvYcCUkH58J2eMSjW1MltskfPfLQS93fK+yq7c0Apcufce3laJIU6/9QH7f/TVRRnSEgu2D1i54si6pZhdqp86n@vger.kernel.org
X-Gm-Message-State: AOJu0Yztvm/2qdAy62WxQdsEricMg+e/eqZ3nk1Yb6iklMbAJGsctWbo
	fWfL6e8LoBU+n0iqd4AQP8GXruC3Wy5pmXfZSmzg6UMhOJEB0T0JWQtHLmCUHA7e+byFKCJbRMk
	ajUBWOezfbr/N6uIL6VrCG+Nlq+w=
X-Gm-Gg: ASbGncv8M3/QFVx6kD9tjxGtSvNojHaF66jvSekhVkDsHu8DxN4WLCpQvkbq4MJOleq
	MRa27dzTwRs8CFg45lR3gHQ+9m7kMDqmTw2E3O+WKaTGTw9wxmKvZfaiLhmm/7uvewoVtqfY5Cx
	1RnRY/Ibndc+Hax7sIoAgtmxTUxl8E8zP4BIwLpg==
X-Google-Smtp-Source: AGHT+IE22CIMJ3/Dy12So6gWQ5dHnjecZh2lK3MyEjrATJvZ3z0iQuEMuG3GgsKEHb+cPpONIvs2MczKNZE3GaOWFGE=
X-Received: by 2002:a05:6214:d65:b0:6e8:c713:31fa with SMTP id
 6a1803df08f44-6f4f1b9b9eamr13701926d6.9.1745878213615; Mon, 28 Apr 2025
 15:10:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426000828.3216220-4-joannelkoong@gmail.com> <202504270319.GmkEM1Xg-lkp@intel.com>
In-Reply-To: <202504270319.GmkEM1Xg-lkp@intel.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 28 Apr 2025 15:10:02 -0700
X-Gm-Features: ATxdqUEue-pjLCwu47H75XWwWB18kNTPsRbl5NdPPz05R0lLZOHA2myeYKL-MTk
Message-ID: <CAJnrk1YT+Q1_Fw4zNm-nutNrM1rA44brtGJKNr2u_zt2XFQwkQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] fuse: refactor fuse_fill_write_pages()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, miklos@szeredi.hu, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	jlayton@kernel.org, jefflexu@linux.alibaba.com, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, willy@infradead.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 27, 2025 at 10:32=E2=80=AFPM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> Hi Joanne,
>
> kernel test robot noticed the following build warnings:
>
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/fuse-=
support-copying-large-folios/20250426-081219
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git=
 for-next
> patch link:    https://lore.kernel.org/r/20250426000828.3216220-4-joannel=
koong%40gmail.com
> patch subject: [PATCH v5 03/11] fuse: refactor fuse_fill_write_pages()
> config: i386-randconfig-141-20250426 (https://download.01.org/0day-ci/arc=
hive/20250427/202504270319.GmkEM1Xg-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202504270319.GmkEM1Xg-lkp@intel.com/
>
> smatch warnings:
> fs/fuse/file.c:1207 fuse_fill_write_pages() error: uninitialized symbol '=
err'.
>
> vim +/err +1207 fs/fuse/file.c
>
> 4f06dd92b5d0a6 Vivek Goyal        2020-10-21  1127  static ssize_t fuse_f=
ill_write_pages(struct fuse_io_args *ia,
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1128                       =
            struct address_space *mapping,
> 338f2e3f3341a9 Miklos Szeredi     2019-09-10  1129                       =
            struct iov_iter *ii, loff_t pos,
> 338f2e3f3341a9 Miklos Szeredi     2019-09-10  1130                       =
            unsigned int max_pages)
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1131  {
> 4f06dd92b5d0a6 Vivek Goyal        2020-10-21  1132      struct fuse_args_=
pages *ap =3D &ia->ap;
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1133      struct fuse_conn =
*fc =3D get_fuse_conn(mapping->host);
> 09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  1134      unsigned offset =
=3D pos & (PAGE_SIZE - 1);
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1135      size_t count =3D =
0;
> dfda790dfda452 Joanne Koong       2025-04-25  1136      unsigned int num;
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1137      int err;
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1138
> dfda790dfda452 Joanne Koong       2025-04-25  1139      num =3D min(iov_i=
ter_count(ii), fc->max_write);
>
> Can iov_iter_count() return zero here?
>
> dfda790dfda452 Joanne Koong       2025-04-25  1140      num =3D min(num, =
max_pages << PAGE_SHIFT);
> dfda790dfda452 Joanne Koong       2025-04-25  1141
> 338f2e3f3341a9 Miklos Szeredi     2019-09-10  1142      ap->args.in_pages=
 =3D true;
> 68bfb7eb7f7de3 Joanne Koong       2024-10-24  1143      ap->descs[0].offs=
et =3D offset;
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1144
> dfda790dfda452 Joanne Koong       2025-04-25  1145      while (num) {
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1146              size_t tm=
p;
> 9bafbe7ae01321 Josef Bacik        2024-09-30  1147              struct fo=
lio *folio;
> 09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  1148              pgoff_t i=
ndex =3D pos >> PAGE_SHIFT;
> dfda790dfda452 Joanne Koong       2025-04-25  1149              unsigned =
bytes =3D min(PAGE_SIZE - offset, num);
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1150
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1151   again:
> 9bafbe7ae01321 Josef Bacik        2024-09-30  1152              folio =3D=
 __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
> 9bafbe7ae01321 Josef Bacik        2024-09-30  1153                       =
                   mapping_gfp_mask(mapping));
> 9bafbe7ae01321 Josef Bacik        2024-09-30  1154              if (IS_ER=
R(folio)) {
> 9bafbe7ae01321 Josef Bacik        2024-09-30  1155                      e=
rr =3D PTR_ERR(folio);
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1156                      b=
reak;
> 9bafbe7ae01321 Josef Bacik        2024-09-30  1157              }
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1158
> 931e80e4b3263d anfei zhou         2010-02-02  1159              if (mappi=
ng_writably_mapped(mapping))
> 9bafbe7ae01321 Josef Bacik        2024-09-30  1160                      f=
lush_dcache_folio(folio);
> 931e80e4b3263d anfei zhou         2010-02-02  1161
> 9bafbe7ae01321 Josef Bacik        2024-09-30  1162              tmp =3D c=
opy_folio_from_iter_atomic(folio, offset, bytes, ii);
> 9bafbe7ae01321 Josef Bacik        2024-09-30  1163              flush_dca=
che_folio(folio);
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1164
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1165              if (!tmp)=
 {
> 9bafbe7ae01321 Josef Bacik        2024-09-30  1166                      f=
olio_unlock(folio);
> 9bafbe7ae01321 Josef Bacik        2024-09-30  1167                      f=
olio_put(folio);
> faa794dd2e17e7 Dave Hansen        2025-01-29  1168
> faa794dd2e17e7 Dave Hansen        2025-01-29  1169                      /=
*
> faa794dd2e17e7 Dave Hansen        2025-01-29  1170                       =
* Ensure forward progress by faulting in
> faa794dd2e17e7 Dave Hansen        2025-01-29  1171                       =
* while not holding the folio lock:
> faa794dd2e17e7 Dave Hansen        2025-01-29  1172                       =
*/
> faa794dd2e17e7 Dave Hansen        2025-01-29  1173                      i=
f (fault_in_iov_iter_readable(ii, bytes)) {
> faa794dd2e17e7 Dave Hansen        2025-01-29  1174                       =
       err =3D -EFAULT;
> faa794dd2e17e7 Dave Hansen        2025-01-29  1175                       =
       break;
> faa794dd2e17e7 Dave Hansen        2025-01-29  1176                      }
> faa794dd2e17e7 Dave Hansen        2025-01-29  1177
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1178                      g=
oto again;
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1179              }
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1180
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1181              err =3D 0=
;
> f2ef459bab7326 Joanne Koong       2024-10-24  1182              ap->folio=
s[ap->num_folios] =3D folio;
> 68bfb7eb7f7de3 Joanne Koong       2024-10-24  1183              ap->descs=
[ap->num_folios].length =3D tmp;
> f2ef459bab7326 Joanne Koong       2024-10-24  1184              ap->num_f=
olios++;
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1185
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1186              count +=
=3D tmp;
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1187              pos +=3D =
tmp;
> dfda790dfda452 Joanne Koong       2025-04-25  1188              num -=3D =
tmp;
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1189              offset +=
=3D tmp;
> 09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  1190              if (offse=
t =3D=3D PAGE_SIZE)
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1191                      o=
ffset =3D 0;
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1192
> 4f06dd92b5d0a6 Vivek Goyal        2020-10-21  1193              /* If we =
copied full page, mark it uptodate */
> 4f06dd92b5d0a6 Vivek Goyal        2020-10-21  1194              if (tmp =
=3D=3D PAGE_SIZE)
> 9bafbe7ae01321 Josef Bacik        2024-09-30  1195                      f=
olio_mark_uptodate(folio);
> 4f06dd92b5d0a6 Vivek Goyal        2020-10-21  1196
> 9bafbe7ae01321 Josef Bacik        2024-09-30  1197              if (folio=
_test_uptodate(folio)) {
> 9bafbe7ae01321 Josef Bacik        2024-09-30  1198                      f=
olio_unlock(folio);
> 4f06dd92b5d0a6 Vivek Goyal        2020-10-21  1199              } else {
> f2ef459bab7326 Joanne Koong       2024-10-24  1200                      i=
a->write.folio_locked =3D true;
> 4f06dd92b5d0a6 Vivek Goyal        2020-10-21  1201                      b=
reak;
> 4f06dd92b5d0a6 Vivek Goyal        2020-10-21  1202              }
> dfda790dfda452 Joanne Koong       2025-04-25  1203              if (!fc->=
big_writes || offset !=3D 0)
> 78bb6cb9a890d3 Miklos Szeredi     2008-05-12  1204                      b=
reak;
> dfda790dfda452 Joanne Koong       2025-04-25  1205      }
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1206
> ea9b9907b82a09 Nicholas Piggin    2008-04-30 @1207      return count > 0 =
? count : err;
> ea9b9907b82a09 Nicholas Piggin    2008-04-30  1208  }
>

I'll initialize err to 0 in v6. I'll wait for more reviews/comments on
the patchset before sending that out.

Thanks,
Joanne

> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

