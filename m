Return-Path: <linux-fsdevel+bounces-44959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4814A6FB10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CBC3B641C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E530258CDA;
	Tue, 25 Mar 2025 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8stokNp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DED2571B1;
	Tue, 25 Mar 2025 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905025; cv=none; b=AQOFVUiPTOrR3teZzTFhXIAmAYlwHYDf+DItN90aiEkbkfycJpuaRq9cfZ8K7Wp1W8LCBxrgkHGR94UgtbqI1qnDG0F7MoSqyq6MMfEA7vKALr6UX7SaNp29pZBfF4bZpnLSAcmk+ni6Qki/X1s6bmXSMMuj4Wh+z9mUqn0wF5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905025; c=relaxed/simple;
	bh=nmHGkxmHyJry0ZX08FwwVvEgncr1QB42+YP4ADMAr78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rMFJ0pOmkN5PgzdlZQbc9bi2WpDekmPmp5y+F5c9Fh99/sKNd7fAiaNJ5vMlzHHdgEnbtJU9OYCc8sIF8l/QRdkhiQIEbsJDtLo6EtNB9wFdqcBuEHHSzAD3eFIghBTcK+PMqyxscAIahwWs8zOVEz+Rozoc5JF49xK4Qn1obEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8stokNp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3789C4CEEE;
	Tue, 25 Mar 2025 12:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905025;
	bh=nmHGkxmHyJry0ZX08FwwVvEgncr1QB42+YP4ADMAr78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C8stokNpr7dBS5pbLGr75p2zR9Z5E5lnjJIi5FMFx4w1yPnaNsB9NMmqQBRtkfpAS
	 m5D9xLwQKY25aU9wkunIPimypiai/bIZ6XD9oxRJegbXWrcpMM/NuZmLwtZSpFnxg1
	 yJZMDIrQ39tNY8fcJZvm0yoHbkmHKxLbfYXPMLQ/qvk2/5PhxbMjwQzpd6oS8aI7HG
	 SqcYkjCV3B/bJh0AayYqX7vAsLA0grpT2VNk3O4epeJqyb9gmIPsDSJBy2njlEJ/au
	 z9wEwUIw91F9GlgJA7f/NY90sbIZNWMC9aOmqwSeZEXYxBewSjQbLgzbOs7FyFi1jA
	 2bUXqrzqMl3sA==
From: guoren@kernel.org
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	anup@brainfault.org,
	atishp@atishpatra.org,
	oleg@redhat.com,
	kees@kernel.org,
	tglx@linutronix.de,
	will@kernel.org,
	mark.rutland@arm.com,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	rostedt@goodmis.org,
	edumazet@google.com,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	gaohan@iscas.ac.cn,
	shihua@iscas.ac.cn,
	jiawei@iscas.ac.cn,
	wuwei2016@iscas.ac.cn,
	drew@pdp7.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	ctsai390@andestech.com,
	wefu@redhat.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	mingo@redhat.com,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	guoren@kernel.org,
	xiao.w.wang@intel.com,
	qingfang.deng@siflower.com.cn,
	leobras@redhat.com,
	jszhang@kernel.org,
	conor.dooley@microchip.com,
	samuel.holland@sifive.com,
	yongxuan.wang@sifive.com,
	luxu.kernel@bytedance.com,
	david@redhat.com,
	ruanjinjie@huawei.com,
	cuiyunhui@bytedance.com,
	wangkefeng.wang@huawei.com,
	qiaozhe@iscas.ac.cn
Cc: ardb@kernel.org,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-mm@kvack.org,
	linux-crypto@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-btrfs@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-nfs@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: [RFC PATCH V3 01/43] rv64ilp32_abi: uapi: Reuse lp64 ABI interface
Date: Tue, 25 Mar 2025 08:15:42 -0400
Message-Id: <20250325121624.523258-2-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250325121624.523258-1-guoren@kernel.org>
References: <20250325121624.523258-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

The rv64ilp32 abi kernel accommodates the lp64 abi userspace and
leverages the lp64 abi Linux interface. Hence, unify the
BITS_PER_LONG = 32 memory layout to match BITS_PER_LONG = 64.

 #if (__riscv_xlen == 64) && (BITS_PER_LONG == 32)
	union {
		void *datap;
		__u64 __datap;
	};
 #else
	void *datap;
 #endif

This is inspired from include/uapi/linux/kvm.h:

struct kvm_dirty_log {
	...
        union {
                void __user *dirty_bitmap; /* one bit per page */
                __u64 padding2;
        };
};

This is a suggestion solution for __riscv_xlen == 64, but we need a
general way to determine CONFIG_64BIT/32BIT in uapi. Any help are
welcome.

TODO: Find a general way to replace __riscv_xlen for uapi headers.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 include/linux/socket.h                        | 35 +++++++++++++
 include/uapi/asm-generic/siginfo.h            | 50 +++++++++++++++++++
 include/uapi/asm-generic/signal.h             | 35 +++++++++++++
 include/uapi/asm-generic/stat.h               | 25 ++++++++++
 include/uapi/linux/atm.h                      |  7 +++
 include/uapi/linux/atmdev.h                   |  7 +++
 include/uapi/linux/blkpg.h                    |  7 +++
 include/uapi/linux/btrfs.h                    | 19 +++++++
 include/uapi/linux/capi.h                     | 11 ++++
 include/uapi/linux/fs.h                       | 12 +++++
 include/uapi/linux/futex.h                    | 18 +++++++
 include/uapi/linux/if.h                       |  6 +++
 include/uapi/linux/netfilter/x_tables.h       |  8 +++
 include/uapi/linux/netfilter_ipv4/ip_tables.h |  7 +++
 include/uapi/linux/nfs4_mount.h               | 14 ++++++
 include/uapi/linux/ppp-ioctl.h                |  7 +++
 include/uapi/linux/sctp.h                     |  3 ++
 include/uapi/linux/sem.h                      | 38 ++++++++++++++
 include/uapi/linux/socket.h                   |  7 +++
 include/uapi/linux/sysctl.h                   | 32 ++++++++++++
 include/uapi/linux/uhid.h                     |  7 +++
 include/uapi/linux/uio.h                      | 11 ++++
 include/uapi/linux/usb/tmc.h                  | 14 ++++++
 include/uapi/linux/usbdevice_fs.h             | 50 +++++++++++++++++++
 include/uapi/linux/uvcvideo.h                 | 14 ++++++
 include/uapi/linux/vfio.h                     |  7 +++
 include/uapi/linux/videodev2.h                |  7 +++
 27 files changed, 458 insertions(+)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index d18cc47e89bd..a1bc6e2b809e 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -81,12 +81,47 @@ struct msghdr {
 };
 
 struct user_msghdr {
+#if __riscv_xlen == 64
+	union {
+		void		__user *msg_name;	/* ptr to socket address structure */
+		u64		__msg_name;
+	};
+#else
 	void		__user *msg_name;	/* ptr to socket address structure */
+#endif
 	int		msg_namelen;		/* size of socket address structure */
+#if __riscv_xlen == 64
+	union {
+		struct iovec	__user *msg_iov;	/* scatter/gather array */
+		u64		__msg_iov;
+	};
+#else
 	struct iovec	__user *msg_iov;	/* scatter/gather array */
+#endif
+#if __riscv_xlen == 64
+	union {
+		__kernel_size_t	msg_iovlen;		/* # elements in msg_iov */
+		u64 __msg_iovlen;
+	};
+#else
 	__kernel_size_t	msg_iovlen;		/* # elements in msg_iov */
+#endif
+#if __riscv_xlen == 64
+	union {
+		void		__user *msg_control;	/* ancillary data */
+		u64		__msg_control;
+	};
+#else
 	void		__user *msg_control;	/* ancillary data */
+#endif
+#if __riscv_xlen == 64
+	union {
+		__kernel_size_t	msg_controllen;		/* ancillary data buffer length */
+		u64	__msg_controllen;
+	};
+#else
 	__kernel_size_t	msg_controllen;		/* ancillary data buffer length */
+#endif
 	unsigned int	msg_flags;		/* flags on received message */
 };
 
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 5a1ca43b5fc6..5c87b85d7858 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -7,7 +7,14 @@
 
 typedef union sigval {
 	int sival_int;
+#if __riscv_xlen == 64
+	union {
+		void __user *sival_ptr;
+		__u64 __sival_ptr;
+	};
+#else
 	void __user *sival_ptr;
+#endif
 } sigval_t;
 
 #define SI_MAX_SIZE	128
@@ -67,7 +74,14 @@ union __sifields {
 
 	/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGTRAP, SIGEMT */
 	struct {
+#if __riscv_xlen == 64
+		union {
+			void __user *_addr; /* faulting insn/memory ref. */
+			__u64 ___addr;
+		};
+#else
 		void __user *_addr; /* faulting insn/memory ref. */
+#endif
 
 #define __ADDR_BND_PKEY_PAD  (__alignof__(void *) < sizeof(short) ? \
 			      sizeof(short) : __alignof__(void *))
@@ -82,8 +96,23 @@ union __sifields {
 			/* used when si_code=SEGV_BNDERR */
 			struct {
 				char _dummy_bnd[__ADDR_BND_PKEY_PAD];
+#if __riscv_xlen == 64
+				union {
+					void __user *_lower;
+					__u64 ___lower;
+				};
+#else
 				void __user *_lower;
+#endif
+
+#if __riscv_xlen == 64
+				union {
+					void __user *_upper;
+					__u64 ___upper;
+				};
+#else
 				void __user *_upper;
+#endif
 			} _addr_bnd;
 			/* used when si_code=SEGV_PKUERR */
 			struct {
@@ -92,7 +121,14 @@ union __sifields {
 			} _addr_pkey;
 			/* used when si_code=TRAP_PERF */
 			struct {
+#if __riscv_xlen == 64
+				union {
+					unsigned long _data;
+					__u64 ___data;
+				};
+#else
 				unsigned long _data;
+#endif
 				__u32 _type;
 				__u32 _flags;
 			} _perf;
@@ -101,13 +137,27 @@ union __sifields {
 
 	/* SIGPOLL */
 	struct {
+#if __riscv_xlen == 64
+		union {
+			__ARCH_SI_BAND_T _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
+			__u64 ___band;
+		};
+#else
 		__ARCH_SI_BAND_T _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
+#endif
 		int _fd;
 	} _sigpoll;
 
 	/* SIGSYS */
 	struct {
+#if __riscv_xlen == 64
+		union {
+			void __user *_call_addr; /* calling user insn */
+			__u64 ___call_addr;
+		};
+#else
 		void __user *_call_addr; /* calling user insn */
+#endif
 		int _syscall;	/* triggering system call number */
 		unsigned int _arch;	/* AUDIT_ARCH_* of syscall */
 	} _sigsys;
diff --git a/include/uapi/asm-generic/signal.h b/include/uapi/asm-generic/signal.h
index 0eb69dc8e572..efcd31a677ee 100644
--- a/include/uapi/asm-generic/signal.h
+++ b/include/uapi/asm-generic/signal.h
@@ -73,19 +73,54 @@ typedef unsigned long old_sigset_t;
 
 #ifndef __KERNEL__
 struct sigaction {
+#if __riscv_xlen == 64
+	union {
+		__sighandler_t sa_handler;
+		__u64 __sa_handler;
+	};
+#else
 	__sighandler_t sa_handler;
+#endif
+#if __riscv_xlen == 64
+	union {
+		unsigned long sa_flags;
+		__u64 __sa_flags;
+	};
+#else
 	unsigned long sa_flags;
+#endif
 #ifdef SA_RESTORER
+#if __riscv_xlen == 64
+	union {
+		__sigrestore_t sa_restorer;
+		__u64 __sa_restorer;
+	};
+#else
 	__sigrestore_t sa_restorer;
+#endif
 #endif
 	sigset_t sa_mask;		/* mask last for extensibility */
 };
 #endif
 
 typedef struct sigaltstack {
+#if __riscv_xlen == 64
+	union {
+		void __user *ss_sp;
+		__u64 __ss_sp;
+	};
+#else
 	void __user *ss_sp;
+#endif
 	int ss_flags;
+#if __riscv_xlen == 64
+	union {
+		__kernel_size_t ss_size;
+		__u64 __ss_size;
+	};
+#else
 	__kernel_size_t ss_size;
+#endif
 } stack_t;
 
 #endif /* __ASSEMBLY__ */
diff --git a/include/uapi/asm-generic/stat.h b/include/uapi/asm-generic/stat.h
index 0d962ecd1663..c8908df5213f 100644
--- a/include/uapi/asm-generic/stat.h
+++ b/include/uapi/asm-generic/stat.h
@@ -21,6 +21,30 @@
 
 #define STAT_HAVE_NSEC 1
 
+#if __riscv_xlen == 64
+struct stat {
+	unsigned long long	st_dev;		/* Device.  */
+	unsigned long long	st_ino;		/* File serial number.  */
+	unsigned int	st_mode;	/* File mode.  */
+	unsigned int	st_nlink;	/* Link count.  */
+	unsigned int	st_uid;		/* User ID of the file's owner.  */
+	unsigned int	st_gid;		/* Group ID of the file's group. */
+	unsigned long long	st_rdev;	/* Device number, if device.  */
+	unsigned long long	__pad1;
+	long long		st_size;	/* Size of file, in bytes.  */
+	int		st_blksize;	/* Optimal block size for I/O.  */
+	int		__pad2;
+	long long		st_blocks;	/* Number 512-byte blocks allocated. */
+	long long		st_atime;	/* Time of last access.  */
+	unsigned long long	st_atime_nsec;
+	long long		st_mtime;	/* Time of last modification.  */
+	unsigned long long	st_mtime_nsec;
+	long long		st_ctime;	/* Time of last status change.  */
+	unsigned long long	st_ctime_nsec;
+	unsigned int	__unused4;
+	unsigned int	__unused5;
+};
+#else
 struct stat {
 	unsigned long	st_dev;		/* Device.  */
 	unsigned long	st_ino;		/* File serial number.  */
@@ -43,6 +67,7 @@ struct stat {
 	unsigned int	__unused4;
 	unsigned int	__unused5;
 };
+#endif
 
 /* This matches struct stat64 in glibc2.1. Only used for 32 bit. */
 #if __BITS_PER_LONG != 64 || defined(__ARCH_WANT_STAT64)
diff --git a/include/uapi/linux/atm.h b/include/uapi/linux/atm.h
index 95ebdcf4fe88..fe0da6a5e26d 100644
--- a/include/uapi/linux/atm.h
+++ b/include/uapi/linux/atm.h
@@ -234,7 +234,14 @@ static __inline__ int atmpvc_addr_in_use(struct sockaddr_atmpvc addr)
 struct atmif_sioc {
 	int number;
 	int length;
+#if __riscv_xlen == 64
+	union {
+		void __user *arg;
+		__u64 __arg;
+	};
+#else
 	void __user *arg;
+#endif
 };
 
 
diff --git a/include/uapi/linux/atmdev.h b/include/uapi/linux/atmdev.h
index 20b0215084fc..e0456ed8b698 100644
--- a/include/uapi/linux/atmdev.h
+++ b/include/uapi/linux/atmdev.h
@@ -155,7 +155,14 @@ struct atm_dev_stats {
 
 struct atm_iobuf {
 	int length;
+#if __riscv_xlen == 64
+	union {
+		void __user *buffer;
+		__u64 __buffer;
+	};
+#else
 	void __user *buffer;
+#endif
 };
 
 /* for ATM_GETCIRANGE / ATM_SETCIRANGE */
diff --git a/include/uapi/linux/blkpg.h b/include/uapi/linux/blkpg.h
index d0a64ee97c6d..31f70c9114c2 100644
--- a/include/uapi/linux/blkpg.h
+++ b/include/uapi/linux/blkpg.h
@@ -12,7 +12,14 @@ struct blkpg_ioctl_arg {
         int op;
         int flags;
         int datalen;
+#if __riscv_xlen == 64
+	union {
+		void __user *data;
+		__u64 __data;
+	};
+#else
         void __user *data;
+#endif
 };
 
 /* The subfunctions (for the op field) */
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index d3b222d7af24..25a9570cbb1c 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -838,7 +838,14 @@ struct btrfs_ioctl_received_subvol_args {
 struct btrfs_ioctl_send_args {
 	__s64 send_fd;			/* in */
 	__u64 clone_sources_count;	/* in */
+#if __riscv_xlen == 64
+	union {
+		__u64 __user *clone_sources;	/* in */
+		__u64 __pad;
+	};
+#else
 	__u64 __user *clone_sources;	/* in */
+#endif
 	__u64 parent_root;		/* in */
 	__u64 flags;			/* in */
 	__u32 version;			/* in */
@@ -959,9 +966,21 @@ struct btrfs_ioctl_encoded_io_args {
 	 * increase in the future). This must also be less than or equal to
 	 * unencoded_len.
 	 */
+#if __riscv_xlen == 64
+	union {
+		const struct iovec __user *iov;
+		const __u64 __iov;
+	};
+	/* Number of iovecs. */
+	union {
+		unsigned long iovcnt;
+		__u64 __iovcnt;
+	};
+#else
 	const struct iovec __user *iov;
 	/* Number of iovecs. */
 	unsigned long iovcnt;
+#endif
 	/*
 	 * Offset in file.
 	 *
diff --git a/include/uapi/linux/capi.h b/include/uapi/linux/capi.h
index 31f946f8a88d..dab4bb8e3ebb 100644
--- a/include/uapi/linux/capi.h
+++ b/include/uapi/linux/capi.h
@@ -77,8 +77,19 @@ typedef struct capi_profile {
 #define CAPI_GET_PROFILE	_IOWR('C',0x09,struct capi_profile)
 
 typedef struct capi_manufacturer_cmd {
+#if __riscv_xlen == 64
+	union {
+		unsigned long cmd;
+		__u64 __cmd;
+	};
+	union {
+		void __user *data;
+		__u64 __data;
+	};
+#else
 	unsigned long cmd;
 	void __user *data;
+#endif
 } capi_manufacturer_cmd;
 
 /*
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 2bbe00cf1248..3ccd123a23a2 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -122,15 +122,27 @@ struct file_dedupe_range {
 
 /* And dynamically-tunable limits and defaults: */
 struct files_stat_struct {
+#if __riscv_xlen == 64
+	unsigned long long nr_files;		/* read only */
+	unsigned long long nr_free_files;	/* read only */
+	unsigned long long max_files;		/* tunable */
+#else
 	unsigned long nr_files;		/* read only */
 	unsigned long nr_free_files;	/* read only */
 	unsigned long max_files;		/* tunable */
+#endif
 };
 
 struct inodes_stat_t {
+#if __riscv_xlen == 64
+	long long nr_inodes;
+	long long nr_unused;
+	long long dummy[5];		/* padding for sysctl ABI compatibility */
+#else
 	long nr_inodes;
 	long nr_unused;
 	long dummy[5];		/* padding for sysctl ABI compatibility */
+#endif
 };
 
 
diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index d2ee625ea189..ae4ee8a66de1 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -108,7 +108,14 @@ struct futex_waitv {
  * changed.
  */
 struct robust_list {
+#if __riscv_xlen == 64
+	union {
+		struct robust_list __user *next;
+		u64 __next;
+	};
+#else
 	struct robust_list __user *next;
+#endif
 };
 
 /*
@@ -131,7 +138,11 @@ struct robust_list_head {
 	 * we keep userspace flexible, to freely shape its data-structure,
 	 * without hardcoding any particular offset into the kernel:
 	 */
+#if __riscv_xlen == 64
+	long long futex_offset;
+#else
 	long futex_offset;
+#endif
 
 	/*
 	 * The death of the thread may race with userspace setting
@@ -143,7 +154,14 @@ struct robust_list_head {
 	 * _might_ have taken. We check the owner TID in any case,
 	 * so only truly owned locks will be handled.
 	 */
+#if __riscv_xlen == 64
+	union {
+		struct robust_list __user *list_op_pending;
+		u64 __list_op_pending;
+	};
+#else
 	struct robust_list __user *list_op_pending;
+#endif
 };
 
 /*
diff --git a/include/uapi/linux/if.h b/include/uapi/linux/if.h
index 797ba2c1562a..232ab74922fe 100644
--- a/include/uapi/linux/if.h
+++ b/include/uapi/linux/if.h
@@ -219,6 +219,9 @@ struct if_settings {
 		/* interface settings */
 		sync_serial_settings	__user *sync;
 		te1_settings		__user *te1;
+#if __riscv_xlen == 64
+		__u64			unused;
+#endif
 	} ifs_ifsu;
 };
 
@@ -288,6 +291,9 @@ struct ifconf  {
 	union {
 		char __user *ifcu_buf;
 		struct ifreq __user *ifcu_req;
+#if __riscv_xlen == 64
+		__u64 unused;
+#endif
 	} ifc_ifcu;
 };
 #endif /* __UAPI_DEF_IF_IFCONF */
diff --git a/include/uapi/linux/netfilter/x_tables.h b/include/uapi/linux/netfilter/x_tables.h
index 796af83a963a..7e02e34c6fad 100644
--- a/include/uapi/linux/netfilter/x_tables.h
+++ b/include/uapi/linux/netfilter/x_tables.h
@@ -18,7 +18,11 @@ struct xt_entry_match {
 			__u8 revision;
 		} user;
 		struct {
+#if __riscv_xlen == 64
+			__u64 match_size;
+#else
 			__u16 match_size;
+#endif
 
 			/* Used inside the kernel */
 			struct xt_match *match;
@@ -41,7 +45,11 @@ struct xt_entry_target {
 			__u8 revision;
 		} user;
 		struct {
+#if __riscv_xlen == 64
+			__u64 target_size;
+#else
 			__u16 target_size;
+#endif
 
 			/* Used inside the kernel */
 			struct xt_target *target;
diff --git a/include/uapi/linux/netfilter_ipv4/ip_tables.h b/include/uapi/linux/netfilter_ipv4/ip_tables.h
index 1485df28b239..3a78f8f7bf5d 100644
--- a/include/uapi/linux/netfilter_ipv4/ip_tables.h
+++ b/include/uapi/linux/netfilter_ipv4/ip_tables.h
@@ -200,7 +200,14 @@ struct ipt_replace {
 	/* Number of counters (must be equal to current number of entries). */
 	unsigned int num_counters;
 	/* The old entries' counters. */
+#if __riscv_xlen == 64
+	union {
+		struct xt_counters __user *counters;
+		__u64 __counters;
+	};
+#else
 	struct xt_counters __user *counters;
+#endif
 
 	/* The entries (hang off end: not really an array). */
 	struct ipt_entry entries[];
diff --git a/include/uapi/linux/nfs4_mount.h b/include/uapi/linux/nfs4_mount.h
index d20bb869bb99..6ec3cec66b6f 100644
--- a/include/uapi/linux/nfs4_mount.h
+++ b/include/uapi/linux/nfs4_mount.h
@@ -21,7 +21,14 @@
 
 struct nfs_string {
 	unsigned int len;
+#if __riscv_xlen == 64
+	union {
+		const char __user * data;
+		__u64 __data;
+	};
+#else
 	const char __user * data;
+#endif
 };
 
 struct nfs4_mount_data {
@@ -53,7 +60,14 @@ struct nfs4_mount_data {
 
 	/* Pseudo-flavours to use for authentication. See RFC2623 */
 	int auth_flavourlen;			/* 1 */
+#if __riscv_xlen == 64
+	union {
+		int __user *auth_flavours;		/* 1 */
+		__u64 __auth_flavours;
+	};
+#else
 	int __user *auth_flavours;		/* 1 */
+#endif
 };
 
 /* bits in the flags field */
diff --git a/include/uapi/linux/ppp-ioctl.h b/include/uapi/linux/ppp-ioctl.h
index 1cc5ce0ae062..8d48eab430c1 100644
--- a/include/uapi/linux/ppp-ioctl.h
+++ b/include/uapi/linux/ppp-ioctl.h
@@ -59,7 +59,14 @@ struct npioctl {
 
 /* Structure describing a CCP configuration option, for PPPIOCSCOMPRESS */
 struct ppp_option_data {
+#if __riscv_xlen == 64
+	union {
+		__u8	__user *ptr;
+		__u64	__ptr;
+	};
+#else
 	__u8	__user *ptr;
+#endif
 	__u32	length;
 	int	transmit;
 };
diff --git a/include/uapi/linux/sctp.h b/include/uapi/linux/sctp.h
index b7d91d4cf0db..46a06fddcd2f 100644
--- a/include/uapi/linux/sctp.h
+++ b/include/uapi/linux/sctp.h
@@ -1024,6 +1024,9 @@ struct sctp_getaddrs_old {
 #else
 	struct sockaddr		*addrs;
 #endif
+#if (__riscv_xlen == 64) && (__SIZEOF_LONG__ == 4)
+	__u32			unused;
+#endif
 };
 
 struct sctp_getaddrs {
diff --git a/include/uapi/linux/sem.h b/include/uapi/linux/sem.h
index 75aa3b273cd9..de9f441913cd 100644
--- a/include/uapi/linux/sem.h
+++ b/include/uapi/linux/sem.h
@@ -26,10 +26,29 @@ struct semid_ds {
 	struct ipc_perm	sem_perm;		/* permissions .. see ipc.h */
 	__kernel_old_time_t sem_otime;		/* last semop time */
 	__kernel_old_time_t sem_ctime;		/* create/last semctl() time */
+#if __riscv_xlen == 64
+	union {
+		struct sem	*sem_base;		/* ptr to first semaphore in array */
+		__u64 __sem_base;
+	};
+	union {
+		struct sem_queue *sem_pending;		/* pending operations to be processed */
+		__u64 __sem_pending;
+	};
+	union {
+		struct sem_queue **sem_pending_last;	/* last pending operation */
+		__u64 __sem_pending_last;
+	};
+	union {
+		struct sem_undo	*undo;			/* undo requests on this array */
+		__u64 __undo;
+	};
+#else
 	struct sem	*sem_base;		/* ptr to first semaphore in array */
 	struct sem_queue *sem_pending;		/* pending operations to be processed */
 	struct sem_queue **sem_pending_last;	/* last pending operation */
 	struct sem_undo	*undo;			/* undo requests on this array */
+#endif
 	unsigned short	sem_nsems;		/* no. of semaphores in array */
 };
 
@@ -46,10 +65,29 @@ struct sembuf {
 /* arg for semctl system calls. */
 union semun {
 	int val;			/* value for SETVAL */
+#if __riscv_xlen == 64
+	union {
+		struct semid_ds __user *buf;	/* buffer for IPC_STAT & IPC_SET */
+		__u64 ___buf;
+	};
+	union {
+		unsigned short __user *array;	/* array for GETALL & SETALL */
+		__u64 __array;
+	};
+	union {
+		struct seminfo __user *__buf;	/* buffer for IPC_INFO */
+		__u64 ____buf;
+	};
+	union {
+		void __user *__pad;
+		__u64 ____pad;
+	};
+#else
 	struct semid_ds __user *buf;	/* buffer for IPC_STAT & IPC_SET */
 	unsigned short __user *array;	/* array for GETALL & SETALL */
 	struct seminfo __user *__buf;	/* buffer for IPC_INFO */
 	void __user *__pad;
+#endif
 };
 
 struct  seminfo {
diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socket.h
index d3fcd3b5ec53..5f7a83649395 100644
--- a/include/uapi/linux/socket.h
+++ b/include/uapi/linux/socket.h
@@ -22,7 +22,14 @@ struct __kernel_sockaddr_storage {
 				/* space to achieve desired size, */
 				/* _SS_MAXSIZE value minus size of ss_family */
 		};
+#if __riscv_xlen == 64
+		union {
+			void *__align; /* implementation specific desired alignment */
+			u64 ___align;
+		};
+#else
 		void *__align; /* implementation specific desired alignment */
+#endif
 	};
 };
 
diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
index 8981f00204db..8ed7b29897f9 100644
--- a/include/uapi/linux/sysctl.h
+++ b/include/uapi/linux/sysctl.h
@@ -33,13 +33,45 @@
 				   member of a struct __sysctl_args to have? */
 
 struct __sysctl_args {
+#if __riscv_xlen == 64
+	union {
+		int __user *name;
+		__u64 __name;
+	};
+#else
 	int __user *name;
+#endif
 	int nlen;
+#if __riscv_xlen == 64
+	union {
+		void __user *oldval;
+		__u64 __oldval;
+	};
+#else
 	void __user *oldval;
+#endif
+#if __riscv_xlen == 64
+	union {
+		size_t __user *oldlenp;
+		__u64 __oldlenp;
+	};
+#else
 	size_t __user *oldlenp;
+#endif
+#if __riscv_xlen == 64
+	union {
+		void __user *newval;
+		__u64 __newval;
+	};
+#else
 	void __user *newval;
+#endif
 	size_t newlen;
+#if __riscv_xlen == 64
+	unsigned long long __unused[4];
+#else
 	unsigned long __unused[4];
+#endif
 };
 
 /* Define sysctl names first */
diff --git a/include/uapi/linux/uhid.h b/include/uapi/linux/uhid.h
index cef7534d2d19..4a774dbd3de8 100644
--- a/include/uapi/linux/uhid.h
+++ b/include/uapi/linux/uhid.h
@@ -130,7 +130,14 @@ struct uhid_create_req {
 	__u8 name[128];
 	__u8 phys[64];
 	__u8 uniq[64];
+#if __riscv_xlen == 64
+	union {
+		__u8 __user *rd_data;
+		__u64 __rd_data;
+	};
+#else
 	__u8 __user *rd_data;
+#endif
 	__u16 rd_size;
 
 	__u16 bus;
diff --git a/include/uapi/linux/uio.h b/include/uapi/linux/uio.h
index 649739e0c404..27dfd6032dc6 100644
--- a/include/uapi/linux/uio.h
+++ b/include/uapi/linux/uio.h
@@ -16,8 +16,19 @@
 
 struct iovec
 {
+#if __riscv_xlen == 64
+	union {
+		void __user *iov_base;	/* BSD uses caddr_t (1003.1g requires void *) */
+		__u64 __iov_base;
+	};
+	union {
+		__kernel_size_t iov_len; /* Must be size_t (1003.1g) */
+		__u64 __iov_len;
+	};
+#else
 	void __user *iov_base;	/* BSD uses caddr_t (1003.1g requires void *) */
 	__kernel_size_t iov_len; /* Must be size_t (1003.1g) */
+#endif
 };
 
 struct dmabuf_cmsg {
diff --git a/include/uapi/linux/usb/tmc.h b/include/uapi/linux/usb/tmc.h
index d791cc58a7f0..443ec5356caf 100644
--- a/include/uapi/linux/usb/tmc.h
+++ b/include/uapi/linux/usb/tmc.h
@@ -51,7 +51,14 @@ struct usbtmc_request {
 
 struct usbtmc_ctrlrequest {
 	struct usbtmc_request req;
+#if __riscv_xlen == 64
+	union {
+		void __user *data; /* pointer to user space */
+		__u64 __data; /* pointer to user space */
+	};
+#else
 	void __user *data; /* pointer to user space */
+#endif
 } __attribute__ ((packed));
 
 struct usbtmc_termchar {
@@ -70,7 +77,14 @@ struct usbtmc_message {
 	__u32 transfer_size; /* size of bytes to transfer */
 	__u32 transferred; /* size of received/written bytes */
 	__u32 flags; /* bit 0: 0 = synchronous; 1 = asynchronous */
+#if __riscv_xlen == 64
+	union {
+		void __user *message; /* pointer to header and data in user space */
+		__u64 __message;
+	};
+#else
 	void __user *message; /* pointer to header and data in user space */
+#endif
 } __attribute__ ((packed));
 
 /* Request values for USBTMC driver's ioctl entry point */
diff --git a/include/uapi/linux/usbdevice_fs.h b/include/uapi/linux/usbdevice_fs.h
index 74a84e02422a..8c8efef74c3c 100644
--- a/include/uapi/linux/usbdevice_fs.h
+++ b/include/uapi/linux/usbdevice_fs.h
@@ -44,14 +44,28 @@ struct usbdevfs_ctrltransfer {
 	__u16 wIndex;
 	__u16 wLength;
 	__u32 timeout;  /* in milliseconds */
+#if __riscv_xlen == 64
+	union {
+		void __user *data;
+		__u64 __data;
+	};
+#else
  	void __user *data;
+#endif
 };
 
 struct usbdevfs_bulktransfer {
 	unsigned int ep;
 	unsigned int len;
 	unsigned int timeout; /* in milliseconds */
+#if __riscv_xlen == 64
+	union {
+		void __user *data;
+		__u64 __data;
+	};
+#else
 	void __user *data;
+#endif
 };
 
 struct usbdevfs_setinterface {
@@ -61,7 +75,14 @@ struct usbdevfs_setinterface {
 
 struct usbdevfs_disconnectsignal {
 	unsigned int signr;
+#if __riscv_xlen == 64
+	union {
+		void __user *context;
+		__u64 __context;
+	};
+#else
 	void __user *context;
+#endif
 };
 
 #define USBDEVFS_MAXDRIVERNAME 255
@@ -119,7 +140,14 @@ struct usbdevfs_urb {
 	unsigned char endpoint;
 	int status;
 	unsigned int flags;
+#if __riscv_xlen == 64
+	union {
+		void __user *buffer;
+		__u64 __buffer;
+	};
+#else
 	void __user *buffer;
+#endif
 	int buffer_length;
 	int actual_length;
 	int start_frame;
@@ -130,7 +158,14 @@ struct usbdevfs_urb {
 	int error_count;
 	unsigned int signr;	/* signal to be sent on completion,
 				  or 0 if none should be sent. */
+#if __riscv_xlen == 64
+	union {
+		void __user *usercontext;
+		__u64 __usercontext;
+	};
+#else
 	void __user *usercontext;
+#endif
 	struct usbdevfs_iso_packet_desc iso_frame_desc[];
 };
 
@@ -139,7 +174,14 @@ struct usbdevfs_ioctl {
 	int	ifno;		/* interface 0..N ; negative numbers reserved */
 	int	ioctl_code;	/* MUST encode size + direction of data so the
 				 * macros in <asm/ioctl.h> give correct values */
+#if __riscv_xlen == 64
+	union {
+		void __user *data;	/* param buffer (in, or out) */
+		__u64 __pad;
+	};
+#else
 	void __user *data;	/* param buffer (in, or out) */
+#endif
 };
 
 /* You can do most things with hubs just through control messages,
@@ -195,9 +237,17 @@ struct usbdevfs_streams {
 #define USBDEVFS_SUBMITURB         _IOR('U', 10, struct usbdevfs_urb)
 #define USBDEVFS_SUBMITURB32       _IOR('U', 10, struct usbdevfs_urb32)
 #define USBDEVFS_DISCARDURB        _IO('U', 11)
+#if __riscv_xlen == 64
+#define USBDEVFS_REAPURB           _IOW('U', 12, __u64)
+#else
 #define USBDEVFS_REAPURB           _IOW('U', 12, void *)
+#endif
 #define USBDEVFS_REAPURB32         _IOW('U', 12, __u32)
+#if __riscv_xlen == 64
+#define USBDEVFS_REAPURBNDELAY     _IOW('U', 13, __u64)
+#else
 #define USBDEVFS_REAPURBNDELAY     _IOW('U', 13, void *)
+#endif
 #define USBDEVFS_REAPURBNDELAY32   _IOW('U', 13, __u32)
 #define USBDEVFS_DISCSIGNAL        _IOR('U', 14, struct usbdevfs_disconnectsignal)
 #define USBDEVFS_DISCSIGNAL32      _IOR('U', 14, struct usbdevfs_disconnectsignal32)
diff --git a/include/uapi/linux/uvcvideo.h b/include/uapi/linux/uvcvideo.h
index f86185456dc5..3ccb99039a43 100644
--- a/include/uapi/linux/uvcvideo.h
+++ b/include/uapi/linux/uvcvideo.h
@@ -54,7 +54,14 @@ struct uvc_xu_control_mapping {
 	__u32 v4l2_type;
 	__u32 data_type;
 
+#if __riscv_xlen == 64
+	union {
+		struct uvc_menu_info __user *menu_info;
+		__u64 __menu_info;
+	};
+#else
 	struct uvc_menu_info __user *menu_info;
+#endif
 	__u32 menu_count;
 
 	__u32 reserved[4];
@@ -66,7 +73,14 @@ struct uvc_xu_control_query {
 	__u8 query;		/* Video Class-Specific Request Code, */
 				/* defined in linux/usb/video.h A.8.  */
 	__u16 size;
+#if __riscv_xlen == 64
+	union {
+		__u8 __user *data;
+		__u64 __data;
+	};
+#else
 	__u8 __user *data;
+#endif
 };
 
 #define UVCIOC_CTRL_MAP		_IOWR('u', 0x20, struct uvc_xu_control_mapping)
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index c8dbf8219c4f..0a1dc2a780fb 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1570,7 +1570,14 @@ struct vfio_iommu_type1_dma_map {
 struct vfio_bitmap {
 	__u64        pgsize;	/* page size for bitmap in bytes */
 	__u64        size;	/* in bytes */
+	#if __riscv_xlen == 64
+	union {
+		__u64 __user *data;	/* one bit per page */
+		__u64 __data;
+	};
+	#else
 	__u64 __user *data;	/* one bit per page */
+	#endif
 };
 
 /**
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index e7c4dce39007..8e5391f07626 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -1898,7 +1898,14 @@ struct v4l2_ext_controls {
 	__u32 error_idx;
 	__s32 request_fd;
 	__u32 reserved[1];
+#if __riscv_xlen == 64
+	union {
+		struct v4l2_ext_control *controls;
+		__u64 __controls;
+	};
+#else
 	struct v4l2_ext_control *controls;
+#endif
 };
 
 #define V4L2_CTRL_ID_MASK	  (0x0fffffff)
-- 
2.40.1


