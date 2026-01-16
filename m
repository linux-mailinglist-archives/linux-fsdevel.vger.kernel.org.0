Return-Path: <linux-fsdevel+bounces-74231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B086CD385A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 20:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08ABD31A4888
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7443A0B3F;
	Fri, 16 Jan 2026 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="tUci4mTJ";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="V1WMo0uW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-174.smtp-out.amazonses.com (a11-174.smtp-out.amazonses.com [54.240.11.174])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD561AC44D;
	Fri, 16 Jan 2026 19:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768590816; cv=none; b=V2nz4Cg2c0EpOnyGNl7TPbnBubkfBWKZ02vi8PyBL+zMKvzBodFQhcizLSve7zInlnagKdWlkZejHn8X2js9XUqgpgXUYfIooxf/QCP82njrr+jFiwkIgskuaUVrnf1lszbKN73Aawed5zDTd+CUuUEhnZniglN+te8mpxhayzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768590816; c=relaxed/simple;
	bh=vmOfOrrUUh14+aiFKVcuQ3nsSTW74+rIkaP2+lDh6Bo=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=E5jfc/9qdXj9oC6nrqwLExGZEgZ5SttQSFhxtdGrpdzjQ/bSsgi0KRdvnoJQ0+td/S6SjA2PZjzsxtuCnK8ZqQu9aqwMt8QaMWmQfWamA/GN9ap3wemnXz2x6Jbtz447T4mlLH4QUk16xZxck7rDH0MC9K9gaqAMu8G35OykX4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=tUci4mTJ; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=V1WMo0uW; arc=none smtp.client-ip=54.240.11.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768590813;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=vmOfOrrUUh14+aiFKVcuQ3nsSTW74+rIkaP2+lDh6Bo=;
	b=tUci4mTJZHxQfd4cKtU3kyI8NpWjb7wsT1Hdn4nokQNKl2uzLLlPUMW1qdFH5oWL
	Qy4wYDcwC1tQoNKIq9KqFKXj7Zt9P9rBrR+JnxyPFx3PIfcN9PZnizH3id2Ay3zYVrn
	ACKZLXv2SbCRcADFKZgKWpIpaWXKFoEqYAAyatcA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768590813;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=vmOfOrrUUh14+aiFKVcuQ3nsSTW74+rIkaP2+lDh6Bo=;
	b=V1WMo0uWasyA/TZKiYQ9LwXFXhAvZmjrN6K+/rz8Dmb2dEvsuTZCpGoZfoLjdVaz
	rCOk2XmH7voEciY8nfCpsbtv7pOBnUAxvOE2G6hD9ogzptNZ9yEBP7zjashCCP6Rr1y
	Efj73CCUjLzuqlrKiQ1DvDbks02OfsTx1ZB6/XzY=
Subject: [PATCH V3 1/2] daxctl: Add support for famfs mode
From: =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To: =?UTF-8?Q?John_Groves?= <John@Groves.net>, 
	=?UTF-8?Q?Miklos_Szeredi?= <miklos@szeredi.hu>, 
	=?UTF-8?Q?Dan_Williams?= <dan.j.williams@intel.com>, 
	=?UTF-8?Q?Bernd_Schubert?= <bschubert@ddn.com>, 
	=?UTF-8?Q?Alison_Schofiel?= =?UTF-8?Q?d?= <alison.schofield@intel.com>
Cc: =?UTF-8?Q?John_Groves?= <jgroves@micron.com>, 
	=?UTF-8?Q?John_Groves?= <jgroves@fastmail.com>, 
	=?UTF-8?Q?Jonathan_Corbet?= <corbet@lwn.net>, 
	=?UTF-8?Q?Vishal_Verma?= <vishal.l.verma@intel.com>, 
	=?UTF-8?Q?Dave_Jiang?= <dave.jiang@intel.com>, 
	=?UTF-8?Q?Matthew_Wilcox?= <willy@infradead.org>, 
	=?UTF-8?Q?Jan_Kara?= <jack@suse.cz>, 
	=?UTF-8?Q?Alexander_Viro?= <viro@zeniv.linux.org.uk>, 
	=?UTF-8?Q?David_Hildenbrand?= <david@kernel.org>, 
	=?UTF-8?Q?Christian_Bra?= =?UTF-8?Q?uner?= <brauner@kernel.org>, 
	=?UTF-8?Q?Darrick_J_=2E_Wong?= <djwong@kernel.org>, 
	=?UTF-8?Q?Randy_Dunlap?= <rdunlap@infradead.org>, 
	=?UTF-8?Q?Jeff_Layton?= <jlayton@kernel.org>, 
	=?UTF-8?Q?Amir_Goldstein?= <amir73il@gmail.com>, 
	=?UTF-8?Q?Jonathan_Cameron?= <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?Q?Stefan_Hajnoczi?= <shajnocz@redhat.com>, 
	=?UTF-8?Q?Joanne_Koong?= <joannelkoong@gmail.com>, 
	=?UTF-8?Q?Josef_Bacik?= <josef@toxicpanda.com>, 
	=?UTF-8?Q?Bagas_Sanjaya?= <bagasdotme@gmail.com>, 
	=?UTF-8?Q?James_Morse?= <james.morse@arm.com>, 
	=?UTF-8?Q?Fuad_Tabba?= <tabba@google.com>, 
	=?UTF-8?Q?Sean_Christopherson?= <seanjc@google.com>, 
	=?UTF-8?Q?Shivank_Garg?= <shivankg@amd.com>, 
	=?UTF-8?Q?Ackerley_Tng?= <ackerleytng@google.com>, 
	=?UTF-8?Q?Gregory_Pric?= =?UTF-8?Q?e?= <gourry@gourry.net>, 
	=?UTF-8?Q?Aravind_Ramesh?= <arramesh@micron.com>, 
	=?UTF-8?Q?Ajay_Joshi?= <ajayjoshi@micron.com>, 
	=?UTF-8?Q?venkataravis=40micron=2Ecom?= <venkataravis@micron.com>, 
	=?UTF-8?Q?linux-doc=40vger=2Ekernel=2Eorg?= <linux-doc@vger.kernel.org>, 
	=?UTF-8?Q?linux-kernel=40vger=2Ekernel=2Eorg?= <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?nvdimm=40lists=2Elinux=2Edev?= <nvdimm@lists.linux.dev>, 
	=?UTF-8?Q?linux-cxl=40vger=2Ekernel=2Eorg?= <linux-cxl@vger.kernel.org>, 
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>
Date: Fri, 16 Jan 2026 19:13:33 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260116191253.1559-1-john@jagalactic.com>
References: <20260116125831.953.compound@groves.net> 
 <20260116191253.1559-1-john@jagalactic.com> 
 <20260116191253.1559-2-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHchxoe1VAe00deR0Sw2d725QhurgAAgGyVAACFhSo=
Thread-Topic: [PATCH V3 1/2] daxctl: Add support for famfs mode
X-Wm-Sent-Timestamp: 1768590812
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bc83a291e-afbcccc9-e262-4f58-9f23-f05802345fda-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.16-54.240.11.174

From: John Groves <John@Groves.net>=0D=0A=0D=0APutting a daxdev in famfs =
mode means binding it to fsdev_dax.ko=0D=0A(drivers/dax/fsdev.c). Finding=
 a daxdev bound to fsdev_dax means=0D=0Ait is in famfs mode.=0D=0A=0D=0AT=
he test is added to the destructive test suite since it=0D=0Amodifies dev=
ice modes.=0D=0A=0D=0AWith devdax, famfs, and system-ram modes, the previ=
ous logic that assumed=0D=0A'not in mode X means in mode Y' needed to get=
 slightly more complicated=0D=0A=0D=0AAdd explicit mode detection functio=
ns:=0D=0A- daxctl_dev_is_famfs_mode(): check if bound to fsdev_dax driver=
=0D=0A- daxctl_dev_is_devdax_mode(): check if bound to device_dax driver=0D=
=0A=0D=0AFix mode transition logic in device.c:=0D=0A- disable_devdax_dev=
ice(): verify device is actually in devdax mode=0D=0A- disable_famfs_devi=
ce(): verify device is actually in famfs mode=0D=0A- All reconfig_mode_*(=
) functions now explicitly check each mode=0D=0A- Handle unknown mode wit=
h error instead of wrong assumption=0D=0A=0D=0AModify json.c to show 'unk=
nown' if device is not in a recognized mode.=0D=0A=0D=0ASigned-off-by: Jo=
hn Groves <john@groves.net>=0D=0A---=0D=0A daxctl/device.c               =
 | 126 ++++++++++++++++++++++++++++++---=0D=0A daxctl/json.c             =
     |   6 +-=0D=0A daxctl/lib/libdaxctl-private.h |   2 +=0D=0A daxctl/l=
ib/libdaxctl.c         |  77 ++++++++++++++++++++=0D=0A daxctl/lib/libdax=
ctl.sym       |   7 ++=0D=0A daxctl/libdaxctl.h             |   3 +=0D=0A=
 6 files changed, 210 insertions(+), 11 deletions(-)=0D=0A=0D=0Adiff --gi=
t a/daxctl/device.c b/daxctl/device.c=0D=0Aindex e3993b1..14e1796 100644=0D=
=0A--- a/daxctl/device.c=0D=0A+++ b/daxctl/device.c=0D=0A@@ -42,6 +42,7 @=
@ enum dev_mode {=0D=0A =09DAXCTL_DEV_MODE_UNKNOWN,=0D=0A =09DAXCTL_DEV_M=
ODE_DEVDAX,=0D=0A =09DAXCTL_DEV_MODE_RAM,=0D=0A+=09DAXCTL_DEV_MODE_FAMFS,=
=0D=0A };=0D=0A=20=0D=0A struct mapping {=0D=0A@@ -471,6 +472,13 @@ stati=
c const char *parse_device_options(int argc, const char **argv,=0D=0A =09=
=09=09=09=09"--no-online is incompatible with --mode=3Ddevdax\n");=0D=0A =
=09=09=09=09rc =3D  -EINVAL;=0D=0A =09=09=09}=0D=0A+=09=09} else if (strc=
mp(param.mode, "famfs") =3D=3D 0) {=0D=0A+=09=09=09reconfig_mode =3D DAXC=
TL_DEV_MODE_FAMFS;=0D=0A+=09=09=09if (param.no_online) {=0D=0A+=09=09=09=09=
fprintf(stderr,=0D=0A+=09=09=09=09=09"--no-online is incompatible with --=
mode=3Dfamfs\n");=0D=0A+=09=09=09=09rc =3D  -EINVAL;=0D=0A+=09=09=09}=0D=0A=
 =09=09}=0D=0A =09=09break;=0D=0A =09case ACTION_CREATE:=0D=0A@@ -696,8 +=
704,42 @@ static int disable_devdax_device(struct daxctl_dev *dev)=0D=0A =
=09int rc;=0D=0A=20=0D=0A =09if (mem) {=0D=0A-=09=09fprintf(stderr, "%s w=
as already in system-ram mode\n",=0D=0A-=09=09=09devname);=0D=0A+=09=09fp=
rintf(stderr, "%s is in system-ram mode\n", devname);=0D=0A+=09=09return =
1;=0D=0A+=09}=0D=0A+=09if (daxctl_dev_is_famfs_mode(dev)) {=0D=0A+=09=09f=
printf(stderr, "%s is in famfs mode\n", devname);=0D=0A+=09=09return 1;=0D=
=0A+=09}=0D=0A+=09if (!daxctl_dev_is_devdax_mode(dev)) {=0D=0A+=09=09fpri=
ntf(stderr, "%s is not in devdax mode\n", devname);=0D=0A+=09=09return 1;=
=0D=0A+=09}=0D=0A+=09rc =3D daxctl_dev_disable(dev);=0D=0A+=09if (rc) {=0D=
=0A+=09=09fprintf(stderr, "%s: disable failed: %s\n",=0D=0A+=09=09=09daxc=
tl_dev_get_devname(dev), strerror(-rc));=0D=0A+=09=09return rc;=0D=0A+=09=
}=0D=0A+=09return 0;=0D=0A+}=0D=0A+=0D=0A+static int disable_famfs_device=
(struct daxctl_dev *dev)=0D=0A+{=0D=0A+=09struct daxctl_memory *mem =3D d=
axctl_dev_get_memory(dev);=0D=0A+=09const char *devname =3D daxctl_dev_ge=
t_devname(dev);=0D=0A+=09int rc;=0D=0A+=0D=0A+=09if (mem) {=0D=0A+=09=09f=
printf(stderr, "%s is in system-ram mode\n", devname);=0D=0A+=09=09return=
 1;=0D=0A+=09}=0D=0A+=09if (daxctl_dev_is_devdax_mode(dev)) {=0D=0A+=09=09=
fprintf(stderr, "%s is in devdax mode\n", devname);=0D=0A+=09=09return 1;=
=0D=0A+=09}=0D=0A+=09if (!daxctl_dev_is_famfs_mode(dev)) {=0D=0A+=09=09fp=
rintf(stderr, "%s is not in famfs mode\n", devname);=0D=0A =09=09return 1=
;=0D=0A =09}=0D=0A =09rc =3D daxctl_dev_disable(dev);=0D=0A@@ -711,6 +753=
,7 @@ static int disable_devdax_device(struct daxctl_dev *dev)=0D=0A=20=0D=
=0A static int reconfig_mode_system_ram(struct daxctl_dev *dev)=0D=0A {=0D=
=0A+=09struct daxctl_memory *mem =3D daxctl_dev_get_memory(dev);=0D=0A =09=
const char *devname =3D daxctl_dev_get_devname(dev);=0D=0A =09int rc, ski=
p_enable =3D 0;=0D=0A=20=0D=0A@@ -724,11 +767,21 @@ static int reconfig_m=
ode_system_ram(struct daxctl_dev *dev)=0D=0A =09}=0D=0A=20=0D=0A =09if (d=
axctl_dev_is_enabled(dev)) {=0D=0A-=09=09rc =3D disable_devdax_device(dev=
);=0D=0A-=09=09if (rc < 0)=0D=0A-=09=09=09return rc;=0D=0A-=09=09if (rc >=
 0)=0D=0A+=09=09if (mem) {=0D=0A+=09=09=09/* already in system-ram mode *=
/=0D=0A =09=09=09skip_enable =3D 1;=0D=0A+=09=09} else if (daxctl_dev_is_=
famfs_mode(dev)) {=0D=0A+=09=09=09rc =3D disable_famfs_device(dev);=0D=0A=
+=09=09=09if (rc)=0D=0A+=09=09=09=09return rc;=0D=0A+=09=09} else if (dax=
ctl_dev_is_devdax_mode(dev)) {=0D=0A+=09=09=09rc =3D disable_devdax_devic=
e(dev);=0D=0A+=09=09=09if (rc)=0D=0A+=09=09=09=09return rc;=0D=0A+=09=09}=
 else {=0D=0A+=09=09=09fprintf(stderr, "%s: unknown mode\n", devname);=0D=
=0A+=09=09=09return -EINVAL;=0D=0A+=09=09}=0D=0A =09}=0D=0A=20=0D=0A =09i=
f (!skip_enable) {=0D=0A@@ -750,7 +803,7 @@ static int disable_system_ram=
_device(struct daxctl_dev *dev)=0D=0A =09int rc;=0D=0A=20=0D=0A =09if (!m=
em) {=0D=0A-=09=09fprintf(stderr, "%s was already in devdax mode\n", devn=
ame);=0D=0A+=09=09fprintf(stderr, "%s is not in system-ram mode\n", devna=
me);=0D=0A =09=09return 1;=0D=0A =09}=0D=0A=20=0D=0A@@ -786,12 +839,28 @@=
 static int disable_system_ram_device(struct daxctl_dev *dev)=0D=0A=20=0D=
=0A static int reconfig_mode_devdax(struct daxctl_dev *dev)=0D=0A {=0D=0A=
+=09struct daxctl_memory *mem =3D daxctl_dev_get_memory(dev);=0D=0A+=09co=
nst char *devname =3D daxctl_dev_get_devname(dev);=0D=0A =09int rc;=0D=0A=
=20=0D=0A =09if (daxctl_dev_is_enabled(dev)) {=0D=0A-=09=09rc =3D disable=
_system_ram_device(dev);=0D=0A-=09=09if (rc)=0D=0A-=09=09=09return rc;=0D=
=0A+=09=09if (mem) {=0D=0A+=09=09=09rc =3D disable_system_ram_device(dev)=
;=0D=0A+=09=09=09if (rc)=0D=0A+=09=09=09=09return rc;=0D=0A+=09=09} else =
if (daxctl_dev_is_famfs_mode(dev)) {=0D=0A+=09=09=09rc =3D disable_famfs_=
device(dev);=0D=0A+=09=09=09if (rc)=0D=0A+=09=09=09=09return rc;=0D=0A+=09=
=09} else if (daxctl_dev_is_devdax_mode(dev)) {=0D=0A+=09=09=09/* already=
 in devdax mode, just re-enable */=0D=0A+=09=09=09rc =3D daxctl_dev_disab=
le(dev);=0D=0A+=09=09=09if (rc)=0D=0A+=09=09=09=09return rc;=0D=0A+=09=09=
} else {=0D=0A+=09=09=09fprintf(stderr, "%s: unknown mode\n", devname);=0D=
=0A+=09=09=09return -EINVAL;=0D=0A+=09=09}=0D=0A =09}=0D=0A=20=0D=0A =09r=
c =3D daxctl_dev_enable_devdax(dev);=0D=0A@@ -801,6 +870,40 @@ static int=
 reconfig_mode_devdax(struct daxctl_dev *dev)=0D=0A =09return 0;=0D=0A }=0D=
=0A=20=0D=0A+static int reconfig_mode_famfs(struct daxctl_dev *dev)=0D=0A=
+{=0D=0A+=09struct daxctl_memory *mem =3D daxctl_dev_get_memory(dev);=0D=0A=
+=09const char *devname =3D daxctl_dev_get_devname(dev);=0D=0A+=09int rc;=
=0D=0A+=0D=0A+=09if (daxctl_dev_is_enabled(dev)) {=0D=0A+=09=09if (mem) {=
=0D=0A+=09=09=09fprintf(stderr,=0D=0A+=09=09=09=09"%s is in system-ram mo=
de, must be in devdax mode to convert to famfs\n",=0D=0A+=09=09=09=09devn=
ame);=0D=0A+=09=09=09return -EINVAL;=0D=0A+=09=09} else if (daxctl_dev_is=
_famfs_mode(dev)) {=0D=0A+=09=09=09/* already in famfs mode, just re-enab=
le */=0D=0A+=09=09=09rc =3D daxctl_dev_disable(dev);=0D=0A+=09=09=09if (r=
c)=0D=0A+=09=09=09=09return rc;=0D=0A+=09=09} else if (daxctl_dev_is_devd=
ax_mode(dev)) {=0D=0A+=09=09=09rc =3D disable_devdax_device(dev);=0D=0A+=09=
=09=09if (rc)=0D=0A+=09=09=09=09return rc;=0D=0A+=09=09} else {=0D=0A+=09=
=09=09fprintf(stderr, "%s: unknown mode\n", devname);=0D=0A+=09=09=09retu=
rn -EINVAL;=0D=0A+=09=09}=0D=0A+=09}=0D=0A+=0D=0A+=09rc =3D daxctl_dev_en=
able_famfs(dev);=0D=0A+=09if (rc)=0D=0A+=09=09return rc;=0D=0A+=0D=0A+=09=
return 0;=0D=0A+}=0D=0A+=0D=0A static int do_create(struct daxctl_region =
*region, long long val,=0D=0A =09=09     struct json_object **jdevs)=0D=0A=
 {=0D=0A@@ -887,6 +990,9 @@ static int do_reconfig(struct daxctl_dev *dev=
, enum dev_mode mode,=0D=0A =09case DAXCTL_DEV_MODE_DEVDAX:=0D=0A =09=09r=
c =3D reconfig_mode_devdax(dev);=0D=0A =09=09break;=0D=0A+=09case DAXCTL_=
DEV_MODE_FAMFS:=0D=0A+=09=09rc =3D reconfig_mode_famfs(dev);=0D=0A+=09=09=
break;=0D=0A =09default:=0D=0A =09=09fprintf(stderr, "%s: unknown mode re=
quested: %d\n",=0D=0A =09=09=09devname, mode);=0D=0Adiff --git a/daxctl/j=
son.c b/daxctl/json.c=0D=0Aindex 3cbce9d..01f139b 100644=0D=0A--- a/daxct=
l/json.c=0D=0A+++ b/daxctl/json.c=0D=0A@@ -48,8 +48,12 @@ struct json_obj=
ect *util_daxctl_dev_to_json(struct daxctl_dev *dev,=0D=0A=20=0D=0A =09if=
 (mem)=0D=0A =09=09jobj =3D json_object_new_string("system-ram");=0D=0A-=09=
else=0D=0A+=09else if (daxctl_dev_is_famfs_mode(dev))=0D=0A+=09=09jobj =3D=
 json_object_new_string("famfs");=0D=0A+=09else if (daxctl_dev_is_devdax_=
mode(dev))=0D=0A =09=09jobj =3D json_object_new_string("devdax");=0D=0A+=09=
else=0D=0A+=09=09jobj =3D json_object_new_string("unknown");=0D=0A =09if =
(jobj)=0D=0A =09=09json_object_object_add(jdev, "mode", jobj);=0D=0A=20=0D=
=0Adiff --git a/daxctl/lib/libdaxctl-private.h b/daxctl/lib/libdaxctl-pri=
vate.h=0D=0Aindex ae45311..0bb73e8 100644=0D=0A--- a/daxctl/lib/libdaxctl=
-private.h=0D=0A+++ b/daxctl/lib/libdaxctl-private.h=0D=0A@@ -21,12 +21,1=
4 @@ static const char *dax_subsystems[] =3D {=0D=0A enum daxctl_dev_mode=
 {=0D=0A =09DAXCTL_DEV_MODE_DEVDAX =3D 0,=0D=0A =09DAXCTL_DEV_MODE_RAM,=0D=
=0A+=09DAXCTL_DEV_MODE_FAMFS,=0D=0A =09DAXCTL_DEV_MODE_END,=0D=0A };=0D=0A=
=20=0D=0A static const char *dax_modules[] =3D {=0D=0A =09[DAXCTL_DEV_MOD=
E_DEVDAX] =3D "device_dax",=0D=0A =09[DAXCTL_DEV_MODE_RAM] =3D "kmem",=0D=
=0A+=09[DAXCTL_DEV_MODE_FAMFS] =3D "fsdev_dax",=0D=0A };=0D=0A=20=0D=0A e=
num memory_op {=0D=0Adiff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/lib=
daxctl.c=0D=0Aindex b7fa0de..0a6cbfe 100644=0D=0A--- a/daxctl/lib/libdaxc=
tl.c=0D=0A+++ b/daxctl/lib/libdaxctl.c=0D=0A@@ -418,6 +418,78 @@ DAXCTL_E=
XPORT int daxctl_dev_is_system_ram_capable(struct daxctl_dev *dev)=0D=0A =
=09return false;=0D=0A }=0D=0A=20=0D=0A+/*=0D=0A+ * Check if device is cu=
rrently in famfs mode (bound to fsdev_dax driver)=0D=0A+ */=0D=0A+DAXCTL_=
EXPORT int daxctl_dev_is_famfs_mode(struct daxctl_dev *dev)=0D=0A+{=0D=0A=
+=09const char *devname =3D daxctl_dev_get_devname(dev);=0D=0A+=09struct =
daxctl_ctx *ctx =3D daxctl_dev_get_ctx(dev);=0D=0A+=09char *mod_path, *mo=
d_base;=0D=0A+=09char path[200];=0D=0A+=09const int len =3D sizeof(path);=
=0D=0A+=0D=0A+=09if (!device_model_is_dax_bus(dev))=0D=0A+=09=09return fa=
lse;=0D=0A+=0D=0A+=09if (!daxctl_dev_is_enabled(dev))=0D=0A+=09=09return =
false;=0D=0A+=0D=0A+=09if (snprintf(path, len, "%s/driver", dev->dev_path=
) >=3D len) {=0D=0A+=09=09err(ctx, "%s: buffer too small!\n", devname);=0D=
=0A+=09=09return false;=0D=0A+=09}=0D=0A+=0D=0A+=09mod_path =3D realpath(=
path, NULL);=0D=0A+=09if (!mod_path)=0D=0A+=09=09return false;=0D=0A+=0D=0A=
+=09mod_base =3D basename(mod_path);=0D=0A+=09if (strcmp(mod_base, dax_mo=
dules[DAXCTL_DEV_MODE_FAMFS]) =3D=3D 0) {=0D=0A+=09=09free(mod_path);=0D=0A=
+=09=09return true;=0D=0A+=09}=0D=0A+=0D=0A+=09free(mod_path);=0D=0A+=09r=
eturn false;=0D=0A+}=0D=0A+=0D=0A+/*=0D=0A+ * Check if device is currentl=
y in devdax mode (bound to device_dax driver)=0D=0A+ */=0D=0A+DAXCTL_EXPO=
RT int daxctl_dev_is_devdax_mode(struct daxctl_dev *dev)=0D=0A+{=0D=0A+=09=
const char *devname =3D daxctl_dev_get_devname(dev);=0D=0A+=09struct daxc=
tl_ctx *ctx =3D daxctl_dev_get_ctx(dev);=0D=0A+=09char *mod_path, *mod_ba=
se;=0D=0A+=09char path[200];=0D=0A+=09const int len =3D sizeof(path);=0D=0A=
+=0D=0A+=09if (!device_model_is_dax_bus(dev))=0D=0A+=09=09return false;=0D=
=0A+=0D=0A+=09if (!daxctl_dev_is_enabled(dev))=0D=0A+=09=09return false;=0D=
=0A+=0D=0A+=09if (snprintf(path, len, "%s/driver", dev->dev_path) >=3D le=
n) {=0D=0A+=09=09err(ctx, "%s: buffer too small!\n", devname);=0D=0A+=09=09=
return false;=0D=0A+=09}=0D=0A+=0D=0A+=09mod_path =3D realpath(path, NULL=
);=0D=0A+=09if (!mod_path)=0D=0A+=09=09return false;=0D=0A+=0D=0A+=09mod_=
base =3D basename(mod_path);=0D=0A+=09if (strcmp(mod_base, dax_modules[DA=
XCTL_DEV_MODE_DEVDAX]) =3D=3D 0) {=0D=0A+=09=09free(mod_path);=0D=0A+=09=09=
return true;=0D=0A+=09}=0D=0A+=0D=0A+=09free(mod_path);=0D=0A+=09return f=
alse;=0D=0A+}=0D=0A+=0D=0A /*=0D=0A  * This checks for the device to be i=
n system-ram mode, so calling=0D=0A  * daxctl_dev_get_memory() on a devda=
x mode device will always return NULL.=0D=0A@@ -982,6 +1054,11 @@ DAXCTL_=
EXPORT int daxctl_dev_enable_ram(struct daxctl_dev *dev)=0D=0A =09return =
daxctl_dev_enable(dev, DAXCTL_DEV_MODE_RAM);=0D=0A }=0D=0A=20=0D=0A+DAXCT=
L_EXPORT int daxctl_dev_enable_famfs(struct daxctl_dev *dev)=0D=0A+{=0D=0A=
+=09return daxctl_dev_enable(dev, DAXCTL_DEV_MODE_FAMFS);=0D=0A+}=0D=0A+=0D=
=0A DAXCTL_EXPORT int daxctl_dev_disable(struct daxctl_dev *dev)=0D=0A {=0D=
=0A =09const char *devname =3D daxctl_dev_get_devname(dev);=0D=0Adiff --g=
it a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym=0D=0Aindex 30988=
11..2a812c6 100644=0D=0A--- a/daxctl/lib/libdaxctl.sym=0D=0A+++ b/daxctl/=
lib/libdaxctl.sym=0D=0A@@ -104,3 +104,10 @@ LIBDAXCTL_10 {=0D=0A global:=0D=
=0A =09daxctl_dev_is_system_ram_capable;=0D=0A } LIBDAXCTL_9;=0D=0A+=0D=0A=
+LIBDAXCTL_11 {=0D=0A+global:=0D=0A+=09daxctl_dev_enable_famfs;=0D=0A+=09=
daxctl_dev_is_famfs_mode;=0D=0A+=09daxctl_dev_is_devdax_mode;=0D=0A+} LIB=
DAXCTL_10;=0D=0Adiff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h=0D=0A=
index 53c6bbd..84fcdb4 100644=0D=0A--- a/daxctl/libdaxctl.h=0D=0A+++ b/da=
xctl/libdaxctl.h=0D=0A@@ -72,12 +72,15 @@ int daxctl_dev_is_enabled(struc=
t daxctl_dev *dev);=0D=0A int daxctl_dev_disable(struct daxctl_dev *dev);=
=0D=0A int daxctl_dev_enable_devdax(struct daxctl_dev *dev);=0D=0A int da=
xctl_dev_enable_ram(struct daxctl_dev *dev);=0D=0A+int daxctl_dev_enable_=
famfs(struct daxctl_dev *dev);=0D=0A int daxctl_dev_get_target_node(struc=
t daxctl_dev *dev);=0D=0A int daxctl_dev_will_auto_online_memory(struct d=
axctl_dev *dev);=0D=0A int daxctl_dev_has_online_memory(struct daxctl_dev=
 *dev);=0D=0A=20=0D=0A struct daxctl_memory;=0D=0A int daxctl_dev_is_syst=
em_ram_capable(struct daxctl_dev *dev);=0D=0A+int daxctl_dev_is_famfs_mod=
e(struct daxctl_dev *dev);=0D=0A+int daxctl_dev_is_devdax_mode(struct dax=
ctl_dev *dev);=0D=0A struct daxctl_memory *daxctl_dev_get_memory(struct d=
axctl_dev *dev);=0D=0A struct daxctl_dev *daxctl_memory_get_dev(struct da=
xctl_memory *mem);=0D=0A const char *daxctl_memory_get_node_path(struct d=
axctl_memory *mem);=0D=0A--=20=0D=0A2.49.0=0D=0A=0D=0A

