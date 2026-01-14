Return-Path: <linux-fsdevel+bounces-73673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD49D1E881
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5966B301C828
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 11:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D62C396D1D;
	Wed, 14 Jan 2026 11:48:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37044399003;
	Wed, 14 Jan 2026 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768391290; cv=none; b=kGHDMkylG2TJNkyBGLC6iw51cCpps7FNkrhC3Kw4SKce6WQQDH3uCfA41UIgfT64CXWDIANDnHv/zzNc7SzfrXgs5uZrtb4Ve+29t5s89Kx5MfSsp0TwM/pRpck1AsRT3Ilk5xOKH+0RUi0GZ4n6IQY9nDqeR7ZXWu/3F9VMUv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768391290; c=relaxed/simple;
	bh=OZgZ5YG15OG22JYQY6PWXweLR+WYGD8unQGsfd3zcWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZ2yiyLbNX0WE3TcdESkt0BwhrMLXaNjZSQeOL9Xt8Q72m1iGI4ApQTkz+7Sd4CyQiN8a5+nsxjyO7bCTKYh6Dgn0vTPBSMZUJc1LkLpmdQzS6ufNIfIYduMoUgM9MbucH5Nqq5dDIERi+7aSg36tHp2XJ7+8cSx+JYjno59hEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98873339;
	Wed, 14 Jan 2026 03:48:00 -0800 (PST)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01C663F59E;
	Wed, 14 Jan 2026 03:48:03 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	dan.carpenter@linaro.org,
	d-gole@ti.com,
	jonathan.cameron@huawei.com,
	elif.topuz@arm.com,
	lukasz.luba@arm.com,
	philip.radford@arm.com,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 12/17] firmware: arm_scmi: Add Telemetry components view
Date: Wed, 14 Jan 2026 11:46:16 +0000
Message-ID: <20260114114638.2290765-13-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114114638.2290765-1-cristian.marussi@arm.com>
References: <20260114114638.2290765-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an alternative filesystem view for the discovered Data Events, where
the tree of DEs is laid out following the discovered topological order
instead of the existing flat layout.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v1 --> v2
 - Use new FS API
 - Introduce new stlmfs_lookup_by_name helper
---
 .../firmware/arm_scmi/scmi_system_telemetry.c | 684 ++++++++++++++++++
 1 file changed, 684 insertions(+)

diff --git a/drivers/firmware/arm_scmi/scmi_system_telemetry.c b/drivers/firmware/arm_scmi/scmi_system_telemetry.c
index 721de615bec3..1221520356fd 100644
--- a/drivers/firmware/arm_scmi/scmi_system_telemetry.c
+++ b/drivers/firmware/arm_scmi/scmi_system_telemetry.c
@@ -174,6 +174,7 @@ struct scmi_tlm_inode {
  * @top_dentry: A reference to the top dentry for this instance.
  * @des_dentry: A reference to the DES dentry for this instance.
  * @grps_dentry: A reference to the groups dentry for this instance.
+ * @compo_dentry: A reference to the components dentry for this instance.
  * @info: A handy reference to this instance SCMI Telemetry info data.
  *
  */
@@ -188,6 +189,7 @@ struct scmi_tlm_instance {
 	struct dentry *top_dentry;
 	struct dentry *des_dentry;
 	struct dentry *grps_dentry;
+	struct dentry *compo_dentry;
 	const struct scmi_telemetry_info *info;
 };
 
@@ -196,6 +198,526 @@ static int scmi_telemetry_instance_register(struct super_block *sb,
 
 static LIST_HEAD(scmi_telemetry_instances);
 
+#define TYPES_ARRAY_SZ		256
+
+static const char *compo_types[TYPES_ARRAY_SZ] = {
+	"unspec",
+	"cpu",
+	"cluster",
+	"gpu",
+	"npu",
+	"interconnnect",
+	"mem_cntrl",
+	"l1_cache",
+	"l2_cache",
+	"l3_cache",
+	"ll_cache",
+	"sys_cache",
+	"disp_cntrl",
+	"ipu",
+	"chiplet",
+	"package",
+	"soc",
+	"system",
+	"smcu",
+	"accel",
+	"battery",
+	"charger",
+	"pmic",
+	"board",
+	"memory",
+	"periph",
+	"periph_subc",
+	"lid",
+	"display",
+	"res_29",
+	"res_30",
+	"res_31",
+	"res_32",
+	"res_33",
+	"res_34",
+	"res_35",
+	"res_36",
+	"res_37",
+	"res_38",
+	"res_39",
+	"res_40",
+	"res_41",
+	"res_42",
+	"res_43",
+	"res_44",
+	"res_45",
+	"res_46",
+	"res_47",
+	"res_48",
+	"res_49",
+	"res_50",
+	"res_51",
+	"res_52",
+	"res_53",
+	"res_54",
+	"res_55",
+	"res_56",
+	"res_57",
+	"res_58",
+	"res_59",
+	"res_60",
+	"res_61",
+	"res_62",
+	"res_63",
+	"res_64",
+	"res_65",
+	"res_66",
+	"res_67",
+	"res_68",
+	"res_69",
+	"res_70",
+	"res_71",
+	"res_72",
+	"res_73",
+	"res_74",
+	"res_75",
+	"res_76",
+	"res_77",
+	"res_78",
+	"res_79",
+	"res_80",
+	"res_81",
+	"res_82",
+	"res_83",
+	"res_84",
+	"res_85",
+	"res_86",
+	"res_87",
+	"res_88",
+	"res_89",
+	"res_90",
+	"res_91",
+	"res_92",
+	"res_93",
+	"res_94",
+	"res_95",
+	"res_96",
+	"res_97",
+	"res_98",
+	"res_99",
+	"res_100",
+	"res_101",
+	"res_102",
+	"res_103",
+	"res_104",
+	"res_105",
+	"res_106",
+	"res_107",
+	"res_108",
+	"res_109",
+	"res_110",
+	"res_111",
+	"res_112",
+	"res_113",
+	"res_114",
+	"res_115",
+	"res_116",
+	"res_117",
+	"res_118",
+	"res_119",
+	"res_120",
+	"res_121",
+	"res_122",
+	"res_123",
+	"res_124",
+	"res_125",
+	"res_126",
+	"res_127",
+	"res_128",
+	"res_129",
+	"res_130",
+	"res_131",
+	"res_132",
+	"res_133",
+	"res_134",
+	"res_135",
+	"res_136",
+	"res_137",
+	"res_138",
+	"res_139",
+	"res_140",
+	"res_141",
+	"res_142",
+	"res_143",
+	"res_144",
+	"res_145",
+	"res_146",
+	"res_147",
+	"res_148",
+	"res_149",
+	"res_150",
+	"res_151",
+	"res_152",
+	"res_153",
+	"res_154",
+	"res_155",
+	"res_156",
+	"res_157",
+	"res_158",
+	"res_159",
+	"res_160",
+	"res_161",
+	"res_162",
+	"res_163",
+	"res_164",
+	"res_165",
+	"res_166",
+	"res_167",
+	"res_168",
+	"res_169",
+	"res_170",
+	"res_171",
+	"res_172",
+	"res_173",
+	"res_174",
+	"res_175",
+	"res_176",
+	"res_177",
+	"res_178",
+	"res_179",
+	"res_180",
+	"res_181",
+	"res_182",
+	"res_183",
+	"res_184",
+	"res_185",
+	"res_186",
+	"res_187",
+	"res_188",
+	"res_189",
+	"res_190",
+	"res_191",
+	"res_192",
+	"res_193",
+	"res_194",
+	"res_195",
+	"res_196",
+	"res_197",
+	"res_198",
+	"res_199",
+	"res_200",
+	"res_201",
+	"res_202",
+	"res_203",
+	"res_204",
+	"res_205",
+	"res_206",
+	"res_207",
+	"res_208",
+	"res_209",
+	"res_210",
+	"res_211",
+	"res_212",
+	"res_213",
+	"res_214",
+	"res_215",
+	"res_216",
+	"res_217",
+	"res_218",
+	"res_219",
+	"res_220",
+	"res_221",
+	"res_222",
+	"res_223",
+	"oem_224",
+	"oem_225",
+	"oem_226",
+	"oem_227",
+	"oem_228",
+	"oem_229",
+	"oem_230",
+	"oem_231",
+	"oem_232",
+	"oem_233",
+	"oem_234",
+	"oem_235",
+	"oem_236",
+	"oem_237",
+	"oem_238",
+	"oem_239",
+	"oem_240",
+	"oem_241",
+	"oem_242",
+	"oem_243",
+	"oem_244",
+	"oem_245",
+	"oem_246",
+	"oem_247",
+	"oem_248",
+	"oem_249",
+	"oem_250",
+	"oem_251",
+	"oem_252",
+	"oem_253",
+	"oem_254",
+	"oem_255",
+};
+
+static const char *unit_types[TYPES_ARRAY_SZ] = {
+	"none",
+	"unspec",
+	"celsius",
+	"fahrenheit",
+	"kelvin",
+	"volts",
+	"amps",
+	"watts",
+	"joules",
+	"coulombs",
+	"va",
+	"nits",
+	"lumens",
+	"lux",
+	"candelas",
+	"kpa",
+	"psi",
+	"newtons",
+	"cfm",
+	"rpm",
+	"hertz",
+	"seconds",
+	"minutes",
+	"hours",
+	"days",
+	"weeks",
+	"mils",
+	"inches",
+	"feet",
+	"cubic_inches",
+	"cubic_feet",
+	"meters",
+	"cubic_centimeters",
+	"cubic_meters",
+	"liters",
+	"fluid_ounces",
+	"radians",
+	"steradians",
+	"revolutions",
+	"cycles",
+	"gravities",
+	"ounces",
+	"pounds",
+	"foot_pounds",
+	"ounce_inches",
+	"gauss",
+	"gilberts",
+	"henries",
+	"farads",
+	"ohms",
+	"siemens",
+	"moles",
+	"becquerels",
+	"ppm",
+	"decibels",
+	"dba",
+	"dbc",
+	"grays",
+	"sieverts",
+	"color_temp_kelvin",
+	"bits",
+	"bytes",
+	"words",
+	"dwords",
+	"qwords",
+	"percentage",
+	"pascals",
+	"counts",
+	"grams",
+	"newton_meters",
+	"hits",
+	"misses",
+	"retries",
+	"overruns",
+	"underruns",
+	"collisions",
+	"packets",
+	"messages",
+	"chars",
+	"errors",
+	"corrected_err",
+	"uncorrectable_err",
+	"square_mils",
+	"square_inches",
+	"square_feet",
+	"square_centimeters",
+	"square_meters",
+	"radians_per_secs",
+	"beats_per_minute",
+	"meters_per_secs_squared",
+	"meters_per_secs",
+	"cubic_meter_per_secs",
+	"millimeters_mercury",
+	"radians_per_secs_squared",
+	"state",
+	"bps",
+	"res_96",
+	"res_97",
+	"res_98",
+	"res_99",
+	"res_100",
+	"res_101",
+	"res_102",
+	"res_103",
+	"res_104",
+	"res_105",
+	"res_106",
+	"res_107",
+	"res_108",
+	"res_109",
+	"res_110",
+	"res_111",
+	"res_112",
+	"res_113",
+	"res_114",
+	"res_115",
+	"res_116",
+	"res_117",
+	"res_118",
+	"res_119",
+	"res_120",
+	"res_121",
+	"res_122",
+	"res_123",
+	"res_124",
+	"res_125",
+	"res_126",
+	"res_127",
+	"res_128",
+	"res_129",
+	"res_130",
+	"res_131",
+	"res_132",
+	"res_133",
+	"res_134",
+	"res_135",
+	"res_136",
+	"res_137",
+	"res_138",
+	"res_139",
+	"res_140",
+	"res_141",
+	"res_142",
+	"res_143",
+	"res_144",
+	"res_145",
+	"res_146",
+	"res_147",
+	"res_148",
+	"res_149",
+	"res_150",
+	"res_151",
+	"res_152",
+	"res_153",
+	"res_154",
+	"res_155",
+	"res_156",
+	"res_157",
+	"res_158",
+	"res_159",
+	"res_160",
+	"res_161",
+	"res_162",
+	"res_163",
+	"res_164",
+	"res_165",
+	"res_166",
+	"res_167",
+	"res_168",
+	"res_169",
+	"res_170",
+	"res_171",
+	"res_172",
+	"res_173",
+	"res_174",
+	"res_175",
+	"res_176",
+	"res_177",
+	"res_178",
+	"res_179",
+	"res_180",
+	"res_181",
+	"res_182",
+	"res_183",
+	"res_184",
+	"res_185",
+	"res_186",
+	"res_187",
+	"res_188",
+	"res_189",
+	"res_190",
+	"res_191",
+	"res_192",
+	"res_193",
+	"res_194",
+	"res_195",
+	"res_196",
+	"res_197",
+	"res_198",
+	"res_199",
+	"res_200",
+	"res_201",
+	"res_202",
+	"res_203",
+	"res_204",
+	"res_205",
+	"res_206",
+	"res_207",
+	"res_208",
+	"res_209",
+	"res_210",
+	"res_211",
+	"res_212",
+	"res_213",
+	"res_214",
+	"res_215",
+	"res_216",
+	"res_217",
+	"res_218",
+	"res_219",
+	"res_220",
+	"res_221",
+	"res_222",
+	"res_223",
+	"res_224",
+	"res_225",
+	"res_226",
+	"res_227",
+	"res_228",
+	"res_229",
+	"res_230",
+	"res_231",
+	"res_232",
+	"res_233",
+	"res_234",
+	"res_235",
+	"res_236",
+	"res_237",
+	"res_238",
+	"res_239",
+	"res_240",
+	"res_241",
+	"res_242",
+	"res_243",
+	"res_244",
+	"res_245",
+	"res_246",
+	"res_247",
+	"res_248",
+	"res_249",
+	"res_250",
+	"res_251",
+	"res_252",
+	"res_253",
+	"res_254",
+	"oem_unit",
+};
+
 static struct inode *stlmfs_get_inode(struct super_block *sb)
 {
 	struct inode *inode = new_inode(sb);
@@ -815,6 +1337,18 @@ DEFINE_TLM_CLASS(persistent_tlmo, "persistent", 0,
 DEFINE_TLM_CLASS(value_tlmo, "value", 0,
 		 S_IFREG | S_IRUSR, &de_read_fops, NULL);
 
+static inline struct dentry *
+stlmfs_lookup_by_name(struct dentry *parent, const char *dname)
+{
+	struct qstr qstr;
+
+	qstr.name = dname;
+	qstr.len = strlen(dname);
+	qstr.hash = full_name_hash(parent, qstr.name, qstr.len);
+
+	return d_lookup(parent, &qstr);
+}
+
 static int scmi_telemetry_de_populate(struct super_block *sb,
 				      struct scmi_tlm_setup *tsp,
 				      struct dentry *parent,
@@ -1659,6 +2193,150 @@ static struct dentry *stlmfs_create_root_dentry(struct super_block *sb)
 	return dentry;
 }
 
+static int scmi_telemetry_de_subdir_symlink(struct super_block *sb,
+					    struct scmi_tlm_setup *tsp,
+					    const struct scmi_telemetry_de *de,
+					    struct dentry *parent)
+{
+	struct dentry *dentry;
+	struct inode *inode;
+	int ret;
+
+	if (IS_ERR(parent))
+		return 0;
+
+	char *name __free(kfree) = kasprintf(GFP_KERNEL, "0x%08X", de->info->id);
+	if (!name)
+		return -ENOMEM;
+
+	char *link __free(kfree) =
+		kasprintf(GFP_KERNEL, "../../../../../des/0x%08X", de->info->id);
+	if (!link)
+		return -ENOMEM;
+
+	dentry = simple_start_creating(parent, name);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
+	inode = stlmfs_get_inode(sb);
+	if (unlikely(!inode)) {
+		dev_err(tsp->dev,
+			"out of free dentries, cannot create '%s'", name);
+		return stlmfs_failed_creating(dentry);
+	}
+
+	inode->i_mode = S_IFLNK | 0777;
+	inode->i_op = &simple_symlink_inode_operations;
+	inode_init_owner(&nop_mnt_idmap, inode, NULL, inode->i_mode);
+	inode->i_link = no_free_ptr(link);
+
+	//d_add(dentry, inode);
+	d_make_persistent(dentry, inode);
+
+	simple_done_creating(dentry);
+
+	return ret;
+}
+
+static struct dentry *
+scmi_telemetry_topology_path_get(struct super_block *sb,
+				 struct scmi_tlm_setup *tsp,
+				 struct dentry *parent, const char *dname)
+{
+	struct dentry *dentry;
+
+	dentry = stlmfs_lookup_by_name(parent, dname);
+	if (!dentry) {
+		struct scmi_tlm_class *dir_tlm_cls __free(kfree) =
+			kzalloc(sizeof(*dir_tlm_cls), GFP_KERNEL);
+		if (!dir_tlm_cls)
+			return NULL;
+
+		dir_tlm_cls->name = kasprintf(GFP_KERNEL, "%s", dname);
+		if (!dir_tlm_cls->name)
+			return NULL;
+
+		dir_tlm_cls->mode = S_IFDIR | S_IRWXU;
+		dir_tlm_cls->flags = TLM_IS_DYNAMIC;
+
+		dentry = stlmfs_create_dentry(sb, tsp, parent,
+					      dir_tlm_cls, NULL);
+		if (!IS_ERR(dentry))
+			retain_and_null_ptr(dir_tlm_cls);
+	}
+
+	return dentry;
+}
+
+static int scmi_telemetry_topology_add_node(struct super_block *sb,
+					    struct scmi_tlm_instance *ti,
+					    const struct scmi_telemetry_de *de)
+{
+	struct dentry *ctype, *cinst, *cunit, *dinst;
+	struct scmi_tlm_de_info *dei = de->info;
+	char inst_str[32];
+	int ret;
+
+	/* by_compo_type/<COMPO_TYPE_STR>/ */
+	ctype = scmi_telemetry_topology_path_get(sb, ti->tsp, ti->compo_dentry,
+						 compo_types[dei->compo_type]);
+	if (!ctype)
+		return -ENOMEM;
+
+	/* by_compo_type/<COMPO_TYPE_STR>/<N>/ */
+	snprintf(inst_str, 32, "%u", dei->compo_instance_id);
+	cinst = scmi_telemetry_topology_path_get(sb, ti->tsp, ctype, inst_str);
+	dput(ctype);
+	if (!cinst)
+		return -ENOMEM;
+
+	/* by_compo_type/<COMPO_TYPE_STR>/<N>/<DE_UNIT_TYPE_STR>/ */
+	cunit = scmi_telemetry_topology_path_get(sb, ti->tsp, cinst,
+						 unit_types[dei->unit]);
+	dput(cinst);
+	if (!cunit)
+		return -ENOMEM;
+
+	/* by_compo_type/<COMPO_TYPE_STR>/<N>/<DE_UNIT_TYPE_STR>/<N> */
+	snprintf(inst_str, 32, "%u", dei->instance_id);
+	dinst = scmi_telemetry_topology_path_get(sb, ti->tsp, cunit, inst_str);
+	dput(cunit);
+	if (!dinst)
+		return -ENOMEM;
+
+	ret = scmi_telemetry_de_subdir_symlink(sb, ti->tsp, de, dinst);
+	dput(dinst);
+
+	return ret;
+}
+
+DEFINE_TLM_CLASS(compo_dir_cls, "components", 0, S_IFDIR | S_IRWXU, NULL, NULL);
+
+static int scmi_telemetry_topology_view_add(struct scmi_tlm_instance *ti)
+{
+	const struct scmi_telemetry_res_info *rinfo;
+	struct scmi_tlm_setup *tsp = ti->tsp;
+	struct device *dev = tsp->dev;
+
+	rinfo = scmi_telemetry_res_info_get(tsp);
+	if (!rinfo || !rinfo->fully_enumerated)
+		return -ENODEV;
+
+	ti->compo_dentry =
+		stlmfs_create_dentry(ti->sb, tsp, ti->top_dentry, &compo_dir_cls, NULL);
+
+	for (int i = 0; i < rinfo->num_des; i++) {
+		int ret;
+
+		ret = scmi_telemetry_topology_add_node(ti->sb, ti, rinfo->des[i]);
+		if (ret)
+			dev_err(dev, "Fail to add node %s to topology. Skip.\n",
+				rinfo->des[i]->info->name);
+	}
+
+	return 0;
+}
+
 static int scmi_tlm_root_dentries_initialize(struct scmi_tlm_instance *ti)
 {
 	struct scmi_tlm_setup *tsp = ti->tsp;
@@ -1712,6 +2390,12 @@ static int scmi_telemetry_instance_register(struct super_block *sb,
 			 ti->top_cls.name);
 	}
 
+	ret = scmi_telemetry_topology_view_add(ti);
+	if (ret)
+		dev_warn(ti->tsp->dev,
+			 "Failed to create topology view for instance %s.\n",
+			 ti->top_cls.name);
+
 	return 0;
 }
 
-- 
2.52.0


