Return-Path: <linux-fsdevel+bounces-74330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F930D39A96
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 23:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 229893001832
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 22:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D1330C345;
	Sun, 18 Jan 2026 22:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="thBUN2ts";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="elAbkQiN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-80.smtp-out.amazonses.com (a11-80.smtp-out.amazonses.com [54.240.11.80])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED4127FD5D;
	Sun, 18 Jan 2026 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768775526; cv=none; b=se+UmsCgIHGP+7jnsrSdglga/k9g1cS92E3FtbQtVCOVHQehkG4PES8Cj0l2+4bcrPHp0Pjx6UXreXEYxS4FqOWazfMxKJSbEE3XxrstIX6bXzNo9twrPCmGWJHjFxks0AwbeSKkJ2O+/oSToWdfxLb8isFWVxuirggtv6Txvek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768775526; c=relaxed/simple;
	bh=rFyTJePw/bkAjwY21ZK/bijznosLCBVKLufzTaPZLoA=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=KBCkP9WoCDGoOdX+HkP+70MKGNuEw1S3xgH1eG3Qh07QYw6/eq6tvSFiv/se6cn4lMtkTRO7aCOzFAWnucwup0I9RiH7QH2H3F67jmZL8KDODUOCGCA7O2E3OR/2riK9s5ctlm3nU9WRni5JeVO7vQ9hucTIOfAEOhvDMBgOOq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=thBUN2ts; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=elAbkQiN; arc=none smtp.client-ip=54.240.11.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768775524;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=rFyTJePw/bkAjwY21ZK/bijznosLCBVKLufzTaPZLoA=;
	b=thBUN2tsmN0Sfg6HPVUh+4MyVKNJN8eY2ez7P+xJPIhulY0b7LnZOjROf1Q8Q1vt
	ib6q6nr60AXwUD48nUaROGF5rTty6cxaqS/s4jeq5uz95vRx0nfmGwm297Zz/e6rMBD
	LMYYvr4lZJXmIlq0ZIp6yIYiMrtjN+G0NtuCVL/0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768775524;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=rFyTJePw/bkAjwY21ZK/bijznosLCBVKLufzTaPZLoA=;
	b=elAbkQiN5unT42W1iuGLaC2QLTHcAcuhLDahobLAsIyYTKj5SKx1EY8n72Hk4BlC
	IVxaSL5w16D0FVQhXgz28qEqafgFhfEhBLgQVhGUZ58ScAX1oWEwPP83MyHKoXAJ08n
	CBKL65p14PGGlhk+qW5ndK/nyoPbvDK1f/4ZrNwI=
Subject: [PATCH V7 06/19] dax: Add dax_set_ops() for setting dax_operations
 at bind time
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
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>, 
	=?UTF-8?Q?John_Groves?= <john@groves.net>
Date: Sun, 18 Jan 2026 22:32:03 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: 
 <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
References: 
 <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com> 
 <20260118223157.92407-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHciMnhcFkpAz6WTSKstYDfyF/cJQAACiwlAAAYu30=
Thread-Topic: [PATCH V7 06/19] dax: Add dax_set_ops() for setting
 dax_operations at bind time
X-Wm-Sent-Timestamp: 1768775522
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bd33c9e30-6de962ed-6feb-4481-a68a-c225ee8808ff-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.18-54.240.11.80

From: John Groves <John@Groves.net>=0D=0A=0D=0AAdd a new dax_set_ops() fu=
nction that allows drivers to set the=0D=0Adax_operations after the dax_d=
evice has been allocated. This is needed=0D=0Afor fsdev_dax where the ope=
rations need to be set during probe and=0D=0Acleared during unbind.=0D=0A=
=0D=0AThe fsdev driver uses devm_add_action_or_reset() for cleanup consis=
tency,=0D=0Aavoiding the complexity of mixing devm-managed resources with=
 manual=0D=0Acleanup in a remove() callback. This ensures cleanup happens=
 automatically=0D=0Ain the correct reverse order when the device is unbou=
nd.=0D=0A=0D=0ASigned-off-by: John Groves <john@groves.net>=0D=0A---=0D=0A=
 drivers/dax/fsdev.c | 16 ++++++++++++++++=0D=0A drivers/dax/super.c | 38=
 +++++++++++++++++++++++++++++++++++++-=0D=0A include/linux/dax.h |  1 +=0D=
=0A 3 files changed, 54 insertions(+), 1 deletion(-)=0D=0A=0D=0Adiff --gi=
t a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c=0D=0Aindex 5d17ad39227f..49=
49aa41dcf4 100644=0D=0A--- a/drivers/dax/fsdev.c=0D=0A+++ b/drivers/dax/f=
sdev.c=0D=0A@@ -119,6 +119,13 @@ static void fsdev_kill(void *dev_dax)=0D=
=0A =09kill_dev_dax(dev_dax);=0D=0A }=0D=0A=20=0D=0A+static void fsdev_cl=
ear_ops(void *data)=0D=0A+{=0D=0A+=09struct dev_dax *dev_dax =3D data;=0D=
=0A+=0D=0A+=09dax_set_ops(dev_dax->dax_dev, NULL);=0D=0A+}=0D=0A+=0D=0A /=
*=0D=0A  * Page map operations for FS-DAX mode=0D=0A  * Similar to fsdax_=
pagemap_ops in drivers/nvdimm/pmem.c=0D=0A@@ -301,6 +308,15 @@ static int=
 fsdev_dax_probe(struct dev_dax *dev_dax)=0D=0A =09if (rc)=0D=0A =09=09re=
turn rc;=0D=0A=20=0D=0A+=09/* Set the dax operations for fs-dax access pa=
th */=0D=0A+=09rc =3D dax_set_ops(dax_dev, &dev_dax_ops);=0D=0A+=09if (rc=
)=0D=0A+=09=09return rc;=0D=0A+=0D=0A+=09rc =3D devm_add_action_or_reset(=
dev, fsdev_clear_ops, dev_dax);=0D=0A+=09if (rc)=0D=0A+=09=09return rc;=0D=
=0A+=0D=0A =09run_dax(dax_dev);=0D=0A =09return devm_add_action_or_reset(=
dev, fsdev_kill, dev_dax);=0D=0A }=0D=0Adiff --git a/drivers/dax/super.c =
b/drivers/dax/super.c=0D=0Aindex c00b9dff4a06..ba0b4cd18a77 100644=0D=0A-=
-- a/drivers/dax/super.c=0D=0A+++ b/drivers/dax/super.c=0D=0A@@ -157,6 +1=
57,9 @@ long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,=
 long nr_pages,=0D=0A =09if (!dax_alive(dax_dev))=0D=0A =09=09return -ENX=
IO;=0D=0A=20=0D=0A+=09if (!dax_dev->ops)=0D=0A+=09=09return -EOPNOTSUPP;=0D=
=0A+=0D=0A =09if (nr_pages < 0)=0D=0A =09=09return -EINVAL;=0D=0A=20=0D=0A=
@@ -207,6 +210,10 @@ int dax_zero_page_range(struct dax_device *dax_dev, =
pgoff_t pgoff,=0D=0A=20=0D=0A =09if (!dax_alive(dax_dev))=0D=0A =09=09ret=
urn -ENXIO;=0D=0A+=0D=0A+=09if (!dax_dev->ops)=0D=0A+=09=09return -EOPNOT=
SUPP;=0D=0A+=0D=0A =09/*=0D=0A =09 * There are no callers that want to ze=
ro more than one page as of now.=0D=0A =09 * Once users are there, this c=
heck can be removed after the=0D=0A@@ -223,7 +230,7 @@ EXPORT_SYMBOL_GPL(=
dax_zero_page_range);=0D=0A size_t dax_recovery_write(struct dax_device *=
dax_dev, pgoff_t pgoff,=0D=0A =09=09void *addr, size_t bytes, struct iov_=
iter *iter)=0D=0A {=0D=0A-=09if (!dax_dev->ops->recovery_write)=0D=0A+=09=
if (!dax_dev->ops || !dax_dev->ops->recovery_write)=0D=0A =09=09return 0;=
=0D=0A =09return dax_dev->ops->recovery_write(dax_dev, pgoff, addr, bytes=
, iter);=0D=0A }=0D=0A@@ -307,6 +314,35 @@ void set_dax_nomc(struct dax_d=
evice *dax_dev)=0D=0A }=0D=0A EXPORT_SYMBOL_GPL(set_dax_nomc);=0D=0A=20=0D=
=0A+/**=0D=0A+ * dax_set_ops - set the dax_operations for a dax_device=0D=
=0A+ * @dax_dev: the dax_device to configure=0D=0A+ * @ops: the operation=
s to set (may be NULL to clear)=0D=0A+ *=0D=0A+ * This allows drivers to =
set the dax_operations after the dax_device=0D=0A+ * has been allocated. =
This is needed when the device is created before=0D=0A+ * the driver that=
 needs specific ops is bound (e.g., fsdev_dax binding=0D=0A+ * to a dev_d=
ax created by hmem).=0D=0A+ *=0D=0A+ * When setting non-NULL ops, fails i=
f ops are already set (returns -EBUSY).=0D=0A+ * When clearing ops (NULL)=
, always succeeds.=0D=0A+ *=0D=0A+ * Return: 0 on success, -EBUSY if ops =
already set=0D=0A+ */=0D=0A+int dax_set_ops(struct dax_device *dax_dev, c=
onst struct dax_operations *ops)=0D=0A+{=0D=0A+=09if (ops) {=0D=0A+=09=09=
/* Setting ops: fail if already set */=0D=0A+=09=09if (cmpxchg(&dax_dev->=
ops, NULL, ops) !=3D NULL)=0D=0A+=09=09=09return -EBUSY;=0D=0A+=09} else =
{=0D=0A+=09=09/* Clearing ops: always allowed */=0D=0A+=09=09dax_dev->ops=
 =3D NULL;=0D=0A+=09}=0D=0A+=09return 0;=0D=0A+}=0D=0A+EXPORT_SYMBOL_GPL(=
dax_set_ops);=0D=0A+=0D=0A bool dax_alive(struct dax_device *dax_dev)=0D=0A=
 {=0D=0A =09lockdep_assert_held(&dax_srcu);=0D=0Adiff --git a/include/lin=
ux/dax.h b/include/linux/dax.h=0D=0Aindex fe1315135fdd..5aaaca135737 1006=
44=0D=0A--- a/include/linux/dax.h=0D=0A+++ b/include/linux/dax.h=0D=0A@@ =
-247,6 +247,7 @@ static inline void dax_break_layout_final(struct inode *=
inode)=0D=0A=20=0D=0A bool dax_alive(struct dax_device *dax_dev);=0D=0A v=
oid *dax_get_private(struct dax_device *dax_dev);=0D=0A+int dax_set_ops(s=
truct dax_device *dax_dev, const struct dax_operations *ops);=0D=0A long =
dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_page=
s,=0D=0A =09=09enum dax_access_mode mode, void **kaddr, unsigned long *pf=
n);=0D=0A size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t p=
goff, void *addr,=0D=0A--=20=0D=0A2.52.0=0D=0A=0D=0A

