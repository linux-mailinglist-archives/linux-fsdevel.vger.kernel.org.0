Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1914017BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 10:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240600AbhIFITc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Sep 2021 04:19:32 -0400
Received: from mail-sn1anam02on2104.outbound.protection.outlook.com ([40.107.96.104]:19444
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240260AbhIFITb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Sep 2021 04:19:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNq0D+2/HSvqKCQbdsgvZIPbB81hJpPDgKeEkfZsZ08tM6y4eIzFOq7qgMKMNt+Zq9uxHyu/n3OiTOE6fT0oTrBqfjjiytfhgArRkTdmK2BGKacOArEAMrPfimiJzt7tvEBu9npAy64C9rodD8/7GXbEZ8BX61JqUqQb2yCLvDoAtsLNFFjGrRA7p+scfrrSmfOh1YDJgFSm6GN6ZCN9xOoDwdYJd1gIT5uArIgxRCabra9tyJ2VybIXz9kjeu0E6NjeunoIu0XFeOoMm3FlRzNFL0Iif2SuWo5veg9F/mVR0lEHRT5Rm10CPp16rHNsO39dzwefNtsKXLf9xQClwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zDRSXiW3hNNWS/Dr8Dr4MVPKjjzD/dKgXQKNylKaChc=;
 b=cULGmrSNSbtCLP7bCBnlVRzzX6VCU+DB0wQNCW6nxHdX/i7CBgKIBd/AAqF35reLWXKqppMbw10/bTWSxd3fxJoNQvfbzwlv5ZZzxK24gGVF5rduotg5nnzlVqaRnaRfnB7nToFChiEQPHUwire/1fMLgr2Ihs0s3diweBIs/ny7hn4qjPS3A6YqPin5x2Mwnw1oZgui8RsA1nc2e47rOCvc2kgYhBBWTqnMOeQj594/3XadmvDxemVtx0NZ7BlyAF8Czv/VKTc7HZBwhn1namIk8BIvvIo9CK9cMiodpho2UF4/u9Wtjgka8WVfHUhGr2wvKxRb6i2pbUQio35dAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDRSXiW3hNNWS/Dr8Dr4MVPKjjzD/dKgXQKNylKaChc=;
 b=MxQvIai4AU0HmnNWAxMDu/mAhaORX6yIlzWA15CE94cnf55SNnahf6pCexcZ0ZTCgFb5Y5C57aTUW7pyiMhtsf2FNIQtlLQg7vrKw+bTer8o24HF0JrtTyPeo1YW3zh16aR8l1nqVW28CVH5uKhFam/D8HcRxDj4fovgdJjZUoU=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) by
 MWHPR0101MB2927.prod.exchangelabs.com (2603:10b6:301:35::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.21; Mon, 6 Sep 2021 08:18:24 +0000
Received: from MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::ed89:1b21:10f4:ed56]) by MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::ed89:1b21:10f4:ed56%3]) with mapi id 15.20.4478.022; Mon, 6 Sep 2021
 08:18:22 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     viro@zeniv.linux.org.uk
Cc:     akpm@linux-foundation.org, jlayton@kernel.org,
        bfields@fieldses.org, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, song.bao.hua@hisilicon.com,
        patches@amperecomputing.com, zwang@amperecomputing.com,
        Huang Shijie <shijie@os.amperecomputing.com>
Subject: [RFC PATCH] fs/exec: Add the support for ELF program's NUMA replication
Date:   Mon,  6 Sep 2021 16:16:13 +0000
Message-Id: <20210906161613.4249-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY4PR21CA0019.namprd21.prod.outlook.com
 (2603:10b6:903:dd::29) To MWHPR0101MB3165.prod.exchangelabs.com
 (2603:10b6:301:2f::19)
MIME-Version: 1.0
Received: from hsj.amperecomputing.com (180.167.209.74) by CY4PR21CA0019.namprd21.prod.outlook.com (2603:10b6:903:dd::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.3 via Frontend Transport; Mon, 6 Sep 2021 08:18:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82c1c7cf-803a-449a-816a-08d9710ee36c
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2927:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0101MB29279CDD49379BBEDCB3DE1CEDD29@MWHPR0101MB2927.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r/ifnc7OKKlt8v/KnvLxoipeOobH9TGhhGOlp9etrOD+VYkPOfgk8jTV3MKVBwUH29OrszrpOoQ3uD7WKkbWeLfgD0Pbs6I4cqBj4+Bi17HUrwGhnyLaujgJxf8NHi2mooJ7L5sROjgsiDM7bHe1G8g5nRywx+JFMn/U/873RNYq9ZpDmqThmLEXQknuCWthN9az8LPC8MDt56AlBBH2FReAXCIwnm8hHko0pO3VN1r6oR6FBgjeuuQ8GHzZw6qpdSm2vF8EORhLH34PfNH+dQLKOyNiSKyIfOIGUi9ue+Mp6B7CvCZOCr6714kP31n4+nTTpGNSKBKH99ishBr7VYohz1vcrNuYdbwn0L8uWzGVoSVn8aFI1AHiBGQA9eb1IIy2ruE3cI6l4mkGAQwYyfY1AyRWaDeAQkJywvvH/3pDXBrFfPu47DBx9MjDCq5TErtyWn+jKE21EJyWfh825HlYKau4hvhkE5G4EURNJXhvxJDGLETbjEI9jzNhtmiSmmqIfOX3P1T8hZ5yKpagcCNEeRh4MrXj4Y3fV6YcDvIOSyAjtjAXi983VbtPdMo7WYgg3JNy8TSE3nyWukFYwWHXrlqp9M3aIBWH8IgW+wHekHEikzDSg5LHdBxs1atBFPM2Z8s/POBKNfODFadZBEiv+fkntSUJnulp8RrwOXv+Kb5lVWjDqkiWh04k+NSGwgIGlvW5acEACkXZuFitxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB3165.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39840400004)(136003)(366004)(396003)(8936002)(83380400001)(107886003)(66946007)(26005)(6916009)(956004)(6486002)(66556008)(66476007)(186003)(6666004)(38350700002)(5660300002)(8676002)(2616005)(6506007)(4326008)(1076003)(86362001)(6512007)(478600001)(38100700002)(316002)(52116002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?APBRol2zn8sBBB55kBHIlvZIoOU9OGvNXMvXi07SuETQAPjC9oap6uVCruZq?=
 =?us-ascii?Q?cv+SArYP9qUWw2ai6jfva5tB+GC9yNaE94rLBrITl2Bv6KjtVhE4SfmmaRjr?=
 =?us-ascii?Q?/ocvi2slihW75YFAsJ5aGxDIkPlgvWz4da5eOVqYqklV3CijNDUYemrkqdDj?=
 =?us-ascii?Q?03p9l5IJxi6RUQB0MJzFEaFJaob6TSzStGaMDdatzeWPnn1CvsXSsiad3uV5?=
 =?us-ascii?Q?nn8GARZnNmJqqZR2W3odi/uO2EictH4BytpA0mecZeSebm6cd8cJcRy1zc3Q?=
 =?us-ascii?Q?CMswZWwRrnorOOzM3s1tEm4CM5nJ1jNpylBw1nKkTha3pXlMo+63ka8loaws?=
 =?us-ascii?Q?kMm+K4WWATxykj371xAN5ZPw61Ra/V4ntrp4XPVF02tjciABve0m6iWV+n/c?=
 =?us-ascii?Q?BG1pWvjdXrSSi7y04P5nCL1wDvvqZFXKCQN+z1cs7jRYnBsZk8FKuw3I1Jj1?=
 =?us-ascii?Q?9MJn6PhSBjHMyrOhKqcSbBRHCoo8PSp9TtG3YyaJibdTPfdq56KnvVorBU2o?=
 =?us-ascii?Q?nnUTaIenB3q9neqHgbAcQdBPMt+cgSUbriqJJP0t7E9AsgszPaTFozdBZ01G?=
 =?us-ascii?Q?SMLAXcppjIQVd5c/4hcCYxuEPjgMNdw8Xx0p2dMKg7MWDWe1ngv6P4ILEuPZ?=
 =?us-ascii?Q?p5xcd83VINDjMEFxEDtXStdcYIfcMxMFCc0HYk3NjTzA9CYNtHwKly2u+w7W?=
 =?us-ascii?Q?erQ28GcE9IwMyc0uUK9mRvOLj09aQTyIG9gmr3wYPXLZMjhWl+tF5dCnSUFp?=
 =?us-ascii?Q?RRLliACqk1WIzPTvpU23omoxdhpjRFH8k8NYPRg9KJULFkLqogbsx8oIHdZQ?=
 =?us-ascii?Q?geCeSdDNDwZX++hNSYzQeXoHLb9xmBp1yHPa8HbTl+6zzsTJkTn/tB55x/qH?=
 =?us-ascii?Q?xZQKWKAdV352kq+Tt5lyHETpdWU/i+HdT+xV/i4D3tv8O4Vq1fvSPfXfExdT?=
 =?us-ascii?Q?YCbIm/ofYUujlenL5gcPHN+9gEtF/0HRU2763UQspPo0INlLUvl5ZCUMJ8HY?=
 =?us-ascii?Q?+9hBnLuas3J9NaGV/MX3pN+ul0JrOk6oNPDPOE3B+MxvE+dm5pMnoXK7Z1+U?=
 =?us-ascii?Q?/gI5e59CM/UueBUPFmWKcRBIJW3mwbhus5gpl8SG/8aeCUVlxAM5rowyFVkX?=
 =?us-ascii?Q?jJyCQfTdLrJCwVP9zZyMBgo39VAhog2oprX1Oe1JgKPyYPEOBGUNKoURnoeg?=
 =?us-ascii?Q?RkZPPS0I+c4LhktaU8164lbJ8+sFEgvPDQZP03X1GEYSNh1xpM3n2/bZ7ugc?=
 =?us-ascii?Q?TYb5t9d7xe3Im8D/fZG3NY/0YL4RWNiefqrOq+U0vTBG5jNVGILd7JyHtWpb?=
 =?us-ascii?Q?I3vXzx8M/Y9DLpOAtUCuiiIr?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c1c7cf-803a-449a-816a-08d9710ee36c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB3165.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2021 08:18:21.9259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7o7GavvjFSO90MVGscCdiJr2bnOFNT4zDfCcqVgdnH6di8khHkg1DEOUEQtDFlz8bE5ramP5MfrEUCGdX0Vj9is+aQgFI/Lr6LrEwKjgmUyCtWb+dew86pbsanAkQf+B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0101MB2927
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds AT_NUMA_REPLICATION for execveat().

If this flag is set, the kernel will trigger COW(copy on write)
on the mmapped ELF binary. So the program will have a copied-page
on its NUMA node, even if the original page in page cache is
on other NUMA nodes.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 fs/binfmt_elf.c            | 27 ++++++++++++++++++++++-----
 fs/exec.c                  |  5 ++++-
 include/linux/binfmts.h    |  1 +
 include/linux/mm.h         |  2 ++
 include/uapi/linux/fcntl.h |  2 ++
 mm/mprotect.c              |  2 +-
 6 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 439ed81e755a..fac8f4a4555a 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -362,13 +362,14 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 
 static unsigned long elf_map(struct file *filep, unsigned long addr,
 		const struct elf_phdr *eppnt, int prot, int type,
-		unsigned long total_size)
+		unsigned long total_size, int numa_replication)
 {
 	unsigned long map_addr;
 	unsigned long size = eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr);
 	unsigned long off = eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr);
 	addr = ELF_PAGESTART(addr);
 	size = ELF_PAGEALIGN(size);
+	int ret;
 
 	/* mmap() will return -EINVAL if given a zero size, but a
 	 * segment with zero filesize is perfectly valid */
@@ -385,11 +386,26 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 	*/
 	if (total_size) {
 		total_size = ELF_PAGEALIGN(total_size);
-		map_addr = vm_mmap(filep, addr, total_size, prot, type, off);
+
+		if (numa_replication) {
+			/* Trigger the COW for this ELF code section */
+			map_addr = vm_mmap(filep, addr, total_size, prot | PROT_WRITE,
+						type | MAP_POPULATE, off);
+			if (!IS_ERR_VALUE(map_addr) && !(prot & PROT_WRITE)) {
+				/* Change back */
+				ret = do_mprotect_pkey(map_addr, total_size, prot, -1);
+				if (ret)
+					return ret;
+			}
+		} else {
+			map_addr = vm_mmap(filep, addr, total_size, prot, type, off);
+		}
+
 		if (!BAD_ADDR(map_addr))
 			vm_munmap(map_addr+size, total_size-size);
-	} else
+	} else {
 		map_addr = vm_mmap(filep, addr, size, prot, type, off);
+	}
 
 	if ((type & MAP_FIXED_NOREPLACE) &&
 	    PTR_ERR((void *)map_addr) == -EEXIST)
@@ -635,7 +651,7 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 				load_addr = -vaddr;
 
 			map_addr = elf_map(interpreter, load_addr + vaddr,
-					eppnt, elf_prot, elf_type, total_size);
+					eppnt, elf_prot, elf_type, total_size, 0);
 			total_size = 0;
 			error = map_addr;
 			if (BAD_ADDR(map_addr))
@@ -1139,7 +1155,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		}
 
 		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
-				elf_prot, elf_flags, total_size);
+				elf_prot, elf_flags, total_size,
+				bprm->support_numa_replication);
 		if (BAD_ADDR(error)) {
 			retval = IS_ERR((void *)error) ?
 				PTR_ERR((void*)error) : -EINVAL;
diff --git a/fs/exec.c b/fs/exec.c
index 38f63451b928..d27efa540641 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -900,7 +900,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 		.lookup_flags = LOOKUP_FOLLOW,
 	};
 
-	if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
+	if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH | AT_NUMA_REPLICATION)) != 0)
 		return ERR_PTR(-EINVAL);
 	if (flags & AT_SYMLINK_NOFOLLOW)
 		open_exec_flags.lookup_flags &= ~LOOKUP_FOLLOW;
@@ -1828,6 +1828,9 @@ static int bprm_execve(struct linux_binprm *bprm,
 	if (retval)
 		goto out;
 
+	/* Do we support NUMA replication for this program? */
+	bprm->support_numa_replication = flags & AT_NUMA_REPLICATION;
+
 	retval = exec_binprm(bprm);
 	if (retval < 0)
 		goto out;
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 049cf9421d83..1874e1732f20 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -64,6 +64,7 @@ struct linux_binprm {
 	struct rlimit rlim_stack; /* Saved RLIMIT_STACK used during exec. */
 
 	char buf[BINPRM_BUF_SIZE];
+	int support_numa_replication;
 } __randomize_layout;
 
 #define BINPRM_FLAGS_ENFORCE_NONDUMP_BIT 0
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7ca22e6e694a..76611381be2a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3244,6 +3244,8 @@ unsigned long wp_shared_mapping_range(struct address_space *mapping,
 #endif
 
 extern int sysctl_nr_trim_pages;
+int do_mprotect_pkey(unsigned long start, size_t len,
+			unsigned long prot, int pkey);
 
 #ifdef CONFIG_PRINTK
 void mem_dump_obj(void *object);
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 2f86b2ad6d7e..de99c5ae8eca 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -111,4 +111,6 @@
 
 #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
 
+#define AT_NUMA_REPLICATION	0x10000	/* Support NUMA replication for the ELF program */
+
 #endif /* _UAPI_LINUX_FCNTL_H */
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 883e2cc85cad..d1f8cececfed 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -519,7 +519,7 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
 /*
  * pkey==-1 when doing a legacy mprotect()
  */
-static int do_mprotect_pkey(unsigned long start, size_t len,
+int do_mprotect_pkey(unsigned long start, size_t len,
 		unsigned long prot, int pkey)
 {
 	unsigned long nstart, end, tmp, reqprot;
-- 
2.30.2

