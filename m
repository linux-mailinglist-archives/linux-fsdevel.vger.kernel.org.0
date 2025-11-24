Return-Path: <linux-fsdevel+bounces-69657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CDEC8087A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 13:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452093A8F93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 12:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B10730101A;
	Mon, 24 Nov 2025 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOE239Ph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A39301461
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 12:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763988203; cv=none; b=YOjXb+rzGfMn6c4K6NwwyX7anT2+lZvMUkTXSHV0SjqEyI2uwRSI1WE2qo0BsbfkWVXAQrh8LWF5qS1LLXi8ghoWCf6fJB5WsSdtrVPeaTMRflRci++DDiDO7ei9Vn9DZOjcSg8qlBKT7sHoaaf5KAkvzPI3B+7u2Wm3A7lyT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763988203; c=relaxed/simple;
	bh=0+XRaDHh9AhAMNbjCO2Aq15hfgUCW2ZWGSTmsgI5AQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPMdxfIiwdQgQeXvhw6iimZKj3xkCLEt6pBVTS05TdkPchE02U7RnJ+HMMFriuKifk6Gi5PjVUaq4oIyptW+4U/xmMydcDPnAQ+xuV0ux4lownWAQcoHanLF27ACq0CiKyr5aWT3MguYw1QVOCvSjxn+OwRIjGxphR/OMUvqB/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hOE239Ph; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763988196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UU7rnxQmBQeCeDYIlVTzrTh2eDouLAQPDrzw0Cbq4EM=;
	b=hOE239PhQNyXuS+Aiwy7PvL/aKoKwOwd31tlgwzm4HHV2xKMGROMwQL7ClbTZAC5HrGxQw
	LbAvqFcMok+hcx+q6m8NKg84pEo0xa39aphw5ltrVM0MNZFBHNKpGPA/U1QGnHRdwRjMmJ
	VTUwi2Oi/RwAfyhbMo5+3DJlJTOTbxQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-O2IorzCjONWSYX6xDQJItg-1; Mon,
 24 Nov 2025 07:43:12 -0500
X-MC-Unique: O2IorzCjONWSYX6xDQJItg-1
X-Mimecast-MFC-AGG-ID: O2IorzCjONWSYX6xDQJItg_1763988191
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A2581954B0D;
	Mon, 24 Nov 2025 12:43:11 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EF49C18004D8;
	Mon, 24 Nov 2025 12:43:07 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Stefan Metzmacher <metze@samba.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH v4 03/11] cifs: Clean up declarations
Date: Mon, 24 Nov 2025 12:42:42 +0000
Message-ID: <20251124124251.3565566-4-dhowells@redhat.com>
In-Reply-To: <20251124124251.3565566-1-dhowells@redhat.com>
References: <20251124124251.3565566-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Use this script, run as "cifs_proto.pl fs/smb/client/*.[ch]" to organise
the function declarations.  Most of the declarations will be split between
cifsproto.h, smb1proto.h and smb2proto.h but with exceptions for
compress.h, fscache.h and cifs_swn.h.

The declarations are inserted into each target proto file in place of line
containing a comment of the form "/* PROTOTYPES */".  The old header
declarations are removed.  Note that this script, as it stands, cannot be
used again on its output as it inserts dividing comments to categorise the
prototypes list by source filename.

The declarations are copied from the .c file, so that the argument names
will match and ordered by appearance in the .c file.

Note that this must be applied on top of the preparatory patch otherwise it
won't work.

use strict;
unless (@ARGV) {
    die "Usage: $0 <c_file1> [<c_file2> ...]\n";
}
my $filename = "-";
my $lineno = 0;
my @proto = "";
my @smb1proto = "";
my @smb2proto = "";
my @smbdirect = "";
my @netlink = "";
my @cached_dir = "";
my @cifs_debug = "";
my @dfs = "";
my @dfs_cache = "";
my @compress = "";
my @fscache = "";
my @swn = "";
my %funcs = ();
sub error(@) {
    print STDERR $filename, ":", $lineno, ": ", @_, "\n";
    exit(1);
}
sub pad($) {
    my ($line) = @_;
    my @lines = split(/[\n]/, $line);
    return $line if ($#lines <= 0);
    for (my $i = 0; $i <= $#lines; $i++) {
	$lines[$i] =~ s/^[ \t]+//;
    }
    my $b = index($lines[0], "(");
    return $line if ($b < 0);
    my $indent = "";
    $b++;
    $indent .= "\t" x ($b / 8);
    $indent .= " " x ($b % 8);
    for (my $i = 1; $i <= $#lines; $i++) {
	$lines[$i] = $indent . $lines[$i];
    }
    my $rev = join("\n", @lines);
    return $rev;
}
foreach my $file (@ARGV) {
    # Open the file for reading.
    next if $file =~ /trace[.]h$/;
    next if $file =~ /smbdirect[.][ch]$/;
    open my $fh, "<$file"
        or die "Could not open file '$file'";
    $filename = $file;
    $lineno = 0;
    my $state = 0;
    my $qual = "";
    my $type = "";
    my $func = "";
    my $funcdef = "";
    my $bracket = 0;
    my $comment = 0;
    my $filemarker = 0;
    my $insecure = 0;
    my $header = 0;
    my $inline = 0;
    my $f_content = "";
    my $copy = "";
    my $config = "";
    $header = 1 if ($file =~ m!.h$!);
    $insecure = 1 if ($file =~ m!/smb1ops.c|/cifssmb.c|/cifstransport.c!);
    foreach my $line (<$fh>) {
        $lineno++;
        $copy .= $line;
        unless ($line) {
            $f_content .= $copy;
            $copy = "";
            next;
        }
        if ($comment) {
            $comment = 0 if ($line =~ m![*]/!);
            $f_content .= $copy;
            $copy = "";
            next;
        }
        if ($line =~ /^[#]/) {
            # if ($line =~ /ifdef.*CONFIG_CIFS_ALLOW_INSECURE_LEGACY/) {
            #   $insecure++;
            # } elsif ($line =~ /endif.*CONFIG_CIFS_ALLOW_INSECURE_LEGACY/) {
            #   $insecure--;
            # }
            if ($header) {
                if ($line =~ /ifdef.*(CONFIG_[A-Z0-9_])/) {
                    error("multiconfig") if $config;
                    $config = $1;
                    $insecure++ if ($config eq "CONFIG_CIFS_ALLOW_INSECURE_LEGACY");
                } elsif ($line =~ /endif/) {
                    $insecure-- if ($config eq "CONFIG_CIFS_ALLOW_INSECURE_LEGACY");
                    $config = "";
                }
            }
            $f_content .= $copy;
            $copy = "";
            next;
        }
        if ($line =~ /^[{]/ ||
            $line =~ /##/ ||
            $line =~ /^[_a-z0-9A-Z]+:$/ || # goto label
            $line =~ /^do [{]/ ||
            $line =~ m!^//!) {
            $f_content .= $copy;
            $copy = "";
            next;
        }
        if ($line =~ m!^/[*]!) {
            $comment = 1 unless ($line =~ m![*]/!);
            $f_content .= $copy;
            $copy = "";
            next;
        }
        if ($line =~ /^[}]/) {
                $type = "";
                $qual = "";
                $func = "";
                $funcdef = "";
                $f_content .= $copy;
                $copy = "";
                next;
        }
        if ($line =~ /^typedef/) {
            $type = "";
            $qual = "";
            $func = "";
            $funcdef = "";
            $f_content .= $copy;
            $copy = "";
            next;
        }
        if ($line =~ /^(static|extern|inline|noinline|noinline_for_stack|__always_inline)\W/) {
            error("Unexpected qualifier '$1'") if ($state != 0);
            while ($line =~ /^(static|extern|inline|noinline|noinline_for_stack|__always_inline)\W/) {
                $qual .= $1 . " ";
                $inline = 1 if ($1 eq "inline");
                $inline = 1 if ($1 eq "__always_inline");
                $line = substr($line, length($1));
                $line =~ s/^\s+//;
            }
        }
        if ($state == 0) {
            if ($line =~ /^\s/) {
                $f_content .= $copy;
                $copy = "";
                next;
            }
            while ($line =~ /^(unsigned|signed|bool|char|short|int|long|void|const|volatile|(struct|union|enum)\s+[_a-zA-Z][_a-zA-Z0-9]*|[*]|__init|__exit|__le16|__le32|__le64|__be16|__be32|__be64)/) {
                $type .= " " if $type;
                $type .= $1;
                $line = substr($line, length($1));
                $line =~ s/^\s+//;
            }
            if ($line =~ /^struct [{]/) {
                $type = "";
                $qual = "";
                $func = "";
                $funcdef = "";
                $f_content .= $copy;
                $copy = "";
                next;
            }
            if (index($line, "=") >= 0) {
                $type = "";
                $qual = "";
                $func = "";
                $funcdef = "";
                $f_content .= $copy;
                $copy = "";
                next;
            }
            while ($line =~ /(^[_a-zA-Z][_a-zA-Z0-9]*)/) {
                my $name = $1;
                $line = substr($line, length($name));
                next if ($line =~ /^[{]/);
                $line =~ s/^\s+//;
                if (substr($line, 0, 1) eq "(") {
                    $state = 1;
                    $line = substr($line, 1);
                    $func = $name;
                    $funcdef = $qual . $type . " " . $func . "(";
                    $funcdef =~ s/[*] /*/;
                    $bracket = 1;
                    last;
                } elsif (substr($line, 0, 1) eq "[") {
                    last;
                } elsif (substr($line, 0, 1) eq ";") {
                    last;
                } else {
                    if ($type) {
                        if (index($line, ";") >= 0 && index($line, "(") == -1) {
                            last;
                        }
                        error("Unexpected name '$name' after '$type'");
                    }
                    $type .= " " if $type;
                    $type .= $name;
                    if ($line =~ /^(\s*[*]+)/) {
                        my $ptr = $1;
                        $type .= $ptr;
                        $line = substr($line, length($ptr));
                    }
                }
            }
        }
        if ($state == 1) {
            my $o;
            my $c;
            while ($o = index($line, "("),
                   $c = index($line, ")"), 1) {
                my $b;
                if ($o == -1) {
                    if ($c == -1) {
                        $funcdef .= $line;
                        last;
                    } else {
                        $b = $c;
                        $bracket--;
                        unless ($bracket) {
                            $funcdef .= substr($line, 0, $b + 1);
                            $line = substr($line, $b + 1);
                            $state = 2;
                            last;
                        }
                    }
                } else {
                    $b = $o;
                    if ($c == -1) {
                        $bracket++;
                    } elsif ($c < $o) {
                        $b = $c;
                        $bracket--;
                        unless ($bracket) {
                            $funcdef .= substr($line, 0, $b + 1);
                            $line = substr($line, $b + 1);
                            $state = 2;
                            last;
                        }
                    } else {
                        $bracket++;
                    }
                }
                $funcdef .= substr($line, 0, $b);
                $line = substr($line, $b + 1);
            }
        }
        if ($state == 2) {
            $inline = 1 if ($qual =~ /inline/);
            if (!$header &&
                $qual !~ /static/ &&
                $func ne "__acquires" &&
                $func ne "__releases" &&
                $func ne "module_init" &&
                $func ne "module_exit" &&
                $func ne "module_param" &&
                $func ne "module_param_call" &&
                $func ne "PROC_FILE_DEFINE" &&
                $func !~ /MODULE_/ &&
                $func !~ /DEFINE_/) {
                my $p;
                if ($insecure) {
                    $p = \@smb1proto;
                } elsif ($file =~ m!/smb2!) {
                    $p = \@smb2proto;
                } elsif ($file =~ m!/smbdirect.c!) {
                    $p = \@smbdirect;
                } elsif ($file =~ m!/netlink.c!) {
                    $p = \@netlink;
                } elsif ($file =~ m!/compress.c!) {
                    $p = \@compress;
                } elsif ($file =~ m!/cached_dir.c!) {
                    $p = \@cached_dir;
                } elsif ($file =~ m!/cifs_debug.c!) {
                    $p = \@cifs_debug;
                } elsif ($file =~ m!/dfs_cache.c!) {
                    $p = \@dfs_cache;
                } elsif ($file =~ m!/dfs.c!) {
                    $p = \@dfs;
                } elsif ($file =~ m!/fscache.c!) {
                    $p = \@fscache;
                } elsif ($file =~ m!/cifs_swn.c!) {
                    $p = \@swn;
                } else {
                    $p = \@proto;
                }
                unless ($filemarker) {
                    my $n = $file;
                    $n =~ s!.*/!!;
                    push @{$p}, "\n/*\n * $n\n */\n";
                    $filemarker = 1;
                }
		$funcdef = pad($funcdef) . ";\n";
		if ($funcdef =~ /cifs_inval_name_dfs_link_error/) {
		    $funcdef = "#ifdef CONFIG_CIFS_DFS_UPCALL\n" . $funcdef . "#endif\n";
		} elsif ($funcdef =~ /cifs_listxattr/) {
		    $funcdef = "#ifdef CONFIG_CIFS_XATTR\n" . $funcdef . "#endif\n";
		}
                push @{$p}, $funcdef;
            } elsif (!$header || $inline) {
                $f_content .= $copy;
            }

            $funcdef = "";
            $type = "";
            $qual = "";
            $func = "";
            $inline = 0;
            $state = 0;
            $copy = "";
        }
        if ($line =~ /;/) {
            $type = "";
            $qual = "";
            $func = "";
            $funcdef = "";
            $state = 0;
            $f_content .= $copy;
            $copy = "";
        }
    }
    close($fh);
    if ($header) {
        $f_content =~ s/[\n]{3,}/\n\n/g;
        open my $fh, ">$file"
            or die "Could not open file '$file' for writing";
        print($fh $f_content) or die $file;
        close($fh) or die $file;
    }
}
sub insert_protos($$)
{
    my ($file, $protos) = @_;
    open my $fh, "<$file"
        or die "Could not open file '$file'";
    my @lines = <$fh>;
    close($fh);
    open $fh, ">$file"
        or die "Could not open file '$file' for writing";
    foreach my $line (@lines) {
        if ($line eq "/* PROTOTYPES */\n") {
            print($fh @{$protos}) or die $file;
        } else {
            print($fh $line) or die $file;
        }
    }
    close($fh) or die $file;
}
insert_protos("fs/smb/client/cifsproto.h", \@proto);
insert_protos("fs/smb/client/smb1proto.h", \@smb1proto);
insert_protos("fs/smb/client/smb2proto.h", \@smb2proto);
insert_protos("fs/smb/client/smbdirect.h", \@smbdirect);
insert_protos("fs/smb/client/netlink.h", \@netlink);
insert_protos("fs/smb/client/compress.h", \@compress);
insert_protos("fs/smb/client/cached_dir.h", \@cached_dir);
insert_protos("fs/smb/client/cifs_debug.h", \@cifs_debug);
insert_protos("fs/smb/client/dfs.h", \@dfs);
insert_protos("fs/smb/client/dfs_cache.h", \@dfs_cache);
insert_protos("fs/smb/client/fscache.h", \@fscache);
insert_protos("fs/smb/client/cifs_swn.h", \@swn);

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cached_dir.h   |   38 +-
 fs/smb/client/cifs_debug.h   |   15 +-
 fs/smb/client/cifs_spnego.h  |    2 -
 fs/smb/client/cifs_swn.h     |   17 +-
 fs/smb/client/cifs_unicode.h |   16 -
 fs/smb/client/cifsfs.h       |   64 --
 fs/smb/client/cifsglob.h     |   22 -
 fs/smb/client/cifspdu.h      |   11 -
 fs/smb/client/cifsproto.h    | 1190 ++++++++++++++++------------------
 fs/smb/client/compress.h     |    6 +-
 fs/smb/client/dfs.h          |   13 +-
 fs/smb/client/dfs_cache.h    |   10 +-
 fs/smb/client/dns_resolve.h  |    3 -
 fs/smb/client/fs_context.h   |    9 -
 fs/smb/client/fscache.h      |   15 +-
 fs/smb/client/netlink.h      |    9 +-
 fs/smb/client/nterr.h        |    2 -
 fs/smb/client/ntlmssp.h      |   13 -
 fs/smb/client/reparse.h      |   11 -
 fs/smb/client/smb1proto.h    |  212 +++++-
 fs/smb/client/smb2proto.h    |  512 +++++++--------
 fs/smb/client/smbdirect.h    |    1 -
 22 files changed, 1083 insertions(+), 1108 deletions(-)

diff --git a/fs/smb/client/cached_dir.h b/fs/smb/client/cached_dir.h
index b843442db2d4..6decac9225a3 100644
--- a/fs/smb/client/cached_dir.h
+++ b/fs/smb/client/cached_dir.h
@@ -8,7 +8,6 @@
 #ifndef _CACHED_DIR_H
 #define _CACHED_DIR_H
 
-
 struct cached_dirent {
 	struct list_head entry;
 	char *name;
@@ -77,23 +76,24 @@ is_valid_cached_dir(struct cached_fid *cfid)
 	return cfid->time && cfid->has_lease;
 }
 
-/* PROTOTYPES */
-extern struct cached_fids *init_cached_dirs(void);
-extern void free_cached_dirs(struct cached_fids *cfids);
-extern int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
-			   const char *path,
-			   struct cifs_sb_info *cifs_sb,
-			   bool lookup_only, struct cached_fid **cfid);
-extern int open_cached_dir_by_dentry(struct cifs_tcon *tcon,
-				     struct dentry *dentry,
-				     struct cached_fid **cfid);
-extern void close_cached_dir(struct cached_fid *cfid);
-extern void drop_cached_dir_by_name(const unsigned int xid,
-				    struct cifs_tcon *tcon,
-				    const char *name,
-				    struct cifs_sb_info *cifs_sb);
-extern void close_all_cached_dirs(struct cifs_sb_info *cifs_sb);
-extern void invalidate_all_cached_dirs(struct cifs_tcon *tcon);
-extern bool cached_dir_lease_break(struct cifs_tcon *tcon, __u8 lease_key[16]);
+
+/*
+ * cached_dir.c
+ */
+int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
+		    const char *path,
+		    struct cifs_sb_info *cifs_sb,
+		    bool lookup_only, struct cached_fid **ret_cfid);
+int open_cached_dir_by_dentry(struct cifs_tcon *tcon,
+			      struct dentry *dentry,
+			      struct cached_fid **ret_cfid);
+void drop_cached_dir_by_name(const unsigned int xid, struct cifs_tcon *tcon,
+			     const char *name, struct cifs_sb_info *cifs_sb);
+void close_cached_dir(struct cached_fid *cfid);
+void close_all_cached_dirs(struct cifs_sb_info *cifs_sb);
+void invalidate_all_cached_dirs(struct cifs_tcon *tcon);
+bool cached_dir_lease_break(struct cifs_tcon *tcon, __u8 lease_key[16]);
+struct cached_fids *init_cached_dirs(void);
+void free_cached_dirs(struct cached_fids *cfids);
 
 #endif			/* _CACHED_DIR_H */
diff --git a/fs/smb/client/cifs_debug.h b/fs/smb/client/cifs_debug.h
index 526afdb33cc6..fd264c39cfbf 100644
--- a/fs/smb/client/cifs_debug.h
+++ b/fs/smb/client/cifs_debug.h
@@ -14,13 +14,19 @@
 
 #define pr_fmt(fmt) "CIFS: " fmt
 
-/* PROTOTYPES */
 
+/*
+ * cifs_debug.c
+ */
 void cifs_dump_mem(char *label, void *data, int length);
-void cifs_dump_detail(void *buf, struct TCP_Server_Info *ptcp_info);
-void cifs_dump_mids(struct TCP_Server_Info *);
+void cifs_dump_detail(void *buf, struct TCP_Server_Info *server);
+void cifs_dump_mids(struct TCP_Server_Info *server);
+void cifs_proc_init(void);
+void cifs_proc_clean(void);
+void cifs_proc_init(void);
+void cifs_proc_clean(void);
+
 extern bool traceSMB;		/* flag which enables the function below */
-void dump_smb(void *, int);
 #define CIFS_INFO	0x01
 #define CIFS_RC		0x02
 #define CIFS_TIMER	0x04
@@ -41,7 +47,6 @@ extern int cifsFYI;
  */
 #ifdef CONFIG_CIFS_DEBUG
 
-
 /*
  * When adding tracepoints and debug messages we have various choices.
  * Some considerations:
diff --git a/fs/smb/client/cifs_spnego.h b/fs/smb/client/cifs_spnego.h
index e4d751b0c812..8eb57900b9ee 100644
--- a/fs/smb/client/cifs_spnego.h
+++ b/fs/smb/client/cifs_spnego.h
@@ -29,8 +29,6 @@ struct cifs_spnego_msg {
 
 #ifdef __KERNEL__
 extern struct key_type cifs_spnego_key_type;
-extern struct key *cifs_get_spnego_key(struct cifs_ses *sesInfo,
-				       struct TCP_Server_Info *server);
 #endif /* KERNEL */
 
 #endif /* _CIFS_SPNEGO_H */
diff --git a/fs/smb/client/cifs_swn.h b/fs/smb/client/cifs_swn.h
index 7063539c41c8..6d4ad7e35953 100644
--- a/fs/smb/client/cifs_swn.h
+++ b/fs/smb/client/cifs_swn.h
@@ -15,16 +15,15 @@ struct genl_info;
 
 #ifdef CONFIG_CIFS_SWN_UPCALL
 
-/* PROTOTYPES */
-extern int cifs_swn_register(struct cifs_tcon *tcon);
 
-extern int cifs_swn_unregister(struct cifs_tcon *tcon);
-
-extern int cifs_swn_notify(struct sk_buff *skb, struct genl_info *info);
-
-extern void cifs_swn_dump(struct seq_file *m);
-
-extern void cifs_swn_check(void);
+/*
+ * cifs_swn.c
+ */
+int cifs_swn_notify(struct sk_buff *skb, struct genl_info *info);
+int cifs_swn_register(struct cifs_tcon *tcon);
+int cifs_swn_unregister(struct cifs_tcon *tcon);
+void cifs_swn_dump(struct seq_file *m);
+void cifs_swn_check(void);
 
 static inline bool cifs_swn_set_server_dstaddr(struct TCP_Server_Info *server)
 {
diff --git a/fs/smb/client/cifs_unicode.h b/fs/smb/client/cifs_unicode.h
index e137a0dfbbe9..55400e7ba70b 100644
--- a/fs/smb/client/cifs_unicode.h
+++ b/fs/smb/client/cifs_unicode.h
@@ -55,22 +55,6 @@
 #define SFU_MAP_UNI_RSVD	2
 
 #ifdef __KERNEL__
-int cifs_from_utf16(char *to, const __le16 *from, int tolen, int fromlen,
-		    const struct nls_table *cp, int map_type);
-int cifs_utf16_bytes(const __le16 *from, int maxbytes,
-		     const struct nls_table *codepage);
-int cifs_strtoUTF16(__le16 *, const char *, int, const struct nls_table *);
-char *cifs_strndup_from_utf16(const char *src, const int maxlen,
-			      const bool is_unicode,
-			      const struct nls_table *codepage);
-extern int cifsConvertToUTF16(__le16 *target, const char *source, int maxlen,
-			      const struct nls_table *cp, int mapChars);
-extern int cifs_remap(struct cifs_sb_info *cifs_sb);
-extern __le16 *cifs_strndup_to_utf16(const char *src, const int maxlen,
-				     int *utf16_len, const struct nls_table *cp,
-				     int remap);
 #endif
 
-wchar_t cifs_toupper(wchar_t in);
-
 #endif /* _CIFS_UNICODE_H */
diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index e9534258d1ef..462be3d9e5cf 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -43,46 +43,14 @@ extern const struct address_space_operations cifs_addr_ops;
 extern const struct address_space_operations cifs_addr_ops_smallbuf;
 
 /* Functions related to super block operations */
-extern void cifs_sb_active(struct super_block *sb);
-extern void cifs_sb_deactive(struct super_block *sb);
 
 /* Functions related to inodes */
 extern const struct inode_operations cifs_dir_inode_ops;
-extern struct inode *cifs_root_iget(struct super_block *);
-extern int cifs_create(struct mnt_idmap *, struct inode *,
-		       struct dentry *, umode_t, bool excl);
-extern int cifs_atomic_open(struct inode *, struct dentry *,
-			    struct file *, unsigned, umode_t);
-extern struct dentry *cifs_lookup(struct inode *, struct dentry *,
-				  unsigned int);
-extern int cifs_unlink(struct inode *dir, struct dentry *dentry);
-extern int cifs_hardlink(struct dentry *, struct inode *, struct dentry *);
-extern int cifs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
-		      umode_t, dev_t);
-extern struct dentry *cifs_mkdir(struct mnt_idmap *, struct inode *, struct dentry *,
-				 umode_t);
-extern int cifs_rmdir(struct inode *, struct dentry *);
-extern int cifs_rename2(struct mnt_idmap *, struct inode *,
-			struct dentry *, struct inode *, struct dentry *,
-			unsigned int);
-extern int cifs_revalidate_file_attr(struct file *filp);
-extern int cifs_revalidate_dentry_attr(struct dentry *);
-extern int cifs_revalidate_file(struct file *filp);
-extern int cifs_revalidate_dentry(struct dentry *);
-extern int cifs_revalidate_mapping(struct inode *inode);
-extern int cifs_zap_mapping(struct inode *inode);
-extern int cifs_getattr(struct mnt_idmap *, const struct path *,
-			struct kstat *, u32, unsigned int);
-extern int cifs_setattr(struct mnt_idmap *, struct dentry *,
-			struct iattr *);
-extern int cifs_fiemap(struct inode *, struct fiemap_extent_info *, u64 start,
-		       u64 len);
 
 extern const struct inode_operations cifs_file_inode_ops;
 extern const struct inode_operations cifs_symlink_inode_ops;
 extern const struct inode_operations cifs_namespace_inode_operations;
 
-
 /* Functions related to files and directories */
 extern const struct netfs_request_ops cifs_req_ops;
 extern const struct file_operations cifs_file_ops;
@@ -91,54 +59,22 @@ extern const struct file_operations cifs_file_strict_ops; /* if strictio mnt */
 extern const struct file_operations cifs_file_nobrl_ops; /* no brlocks */
 extern const struct file_operations cifs_file_direct_nobrl_ops;
 extern const struct file_operations cifs_file_strict_nobrl_ops;
-extern int cifs_open(struct inode *inode, struct file *file);
-extern int cifs_close(struct inode *inode, struct file *file);
-extern int cifs_closedir(struct inode *inode, struct file *file);
-extern ssize_t cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to);
-extern ssize_t cifs_strict_writev(struct kiocb *iocb, struct iov_iter *from);
-ssize_t cifs_file_write_iter(struct kiocb *iocb, struct iov_iter *from);
-ssize_t cifs_loose_read_iter(struct kiocb *iocb, struct iov_iter *iter);
-extern int cifs_flock(struct file *pfile, int cmd, struct file_lock *plock);
-extern int cifs_lock(struct file *, int, struct file_lock *);
-extern int cifs_fsync(struct file *, loff_t, loff_t, int);
-extern int cifs_strict_fsync(struct file *, loff_t, loff_t, int);
-extern int cifs_flush(struct file *, fl_owner_t id);
-int cifs_file_mmap_prepare(struct vm_area_desc *desc);
-int cifs_file_strict_mmap_prepare(struct vm_area_desc *desc);
 extern const struct file_operations cifs_dir_ops;
-extern int cifs_readdir(struct file *file, struct dir_context *ctx);
 
 /* Functions related to dir entries */
 extern const struct dentry_operations cifs_dentry_ops;
 extern const struct dentry_operations cifs_ci_dentry_ops;
 
-extern struct vfsmount *cifs_d_automount(struct path *path);
-
 /* Functions related to symlinks */
-extern const char *cifs_get_link(struct dentry *, struct inode *,
-			struct delayed_call *);
-extern int cifs_symlink(struct mnt_idmap *idmap, struct inode *inode,
-			struct dentry *direntry, const char *symname);
 
 #ifdef CONFIG_CIFS_XATTR
 extern const struct xattr_handler * const cifs_xattr_handlers[];
-extern ssize_t	cifs_listxattr(struct dentry *, char *, size_t);
 #else
 # define cifs_xattr_handlers NULL
 # define cifs_listxattr NULL
 #endif
 
-extern ssize_t cifs_file_copychunk_range(unsigned int xid,
-					struct file *src_file, loff_t off,
-					struct file *dst_file, loff_t destoff,
-					size_t len, unsigned int flags);
-
-extern long cifs_ioctl(struct file *filep, unsigned int cmd, unsigned long arg);
-extern void cifs_setsize(struct inode *inode, loff_t offset);
-
 struct smb3_fs_context;
-extern struct dentry *cifs_smb3_do_mount(struct file_system_type *fs_type,
-					 int flags, struct smb3_fs_context *ctx);
 
 #ifdef CONFIG_CIFS_NFSD_EXPORT
 extern const struct export_operations cifs_export_ops;
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index f859c5407fbc..c74df2260d6b 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1325,9 +1325,6 @@ struct tcon_link {
 	struct cifs_tcon	*tl_tcon;
 };
 
-extern struct tcon_link *cifs_sb_tlink(struct cifs_sb_info *cifs_sb);
-extern void smb3_free_compound_rqst(int num_rqst, struct smb_rqst *rqst);
-
 static inline struct cifs_tcon *
 tlink_tcon(struct tcon_link *tlink)
 {
@@ -1340,8 +1337,6 @@ cifs_sb_master_tlink(struct cifs_sb_info *cifs_sb)
 	return cifs_sb->master_tlink;
 }
 
-extern void cifs_put_tlink(struct tcon_link *tlink);
-
 static inline struct tcon_link *
 cifs_get_tlink(struct tcon_link *tlink)
 {
@@ -1351,7 +1346,6 @@ cifs_get_tlink(struct tcon_link *tlink)
 }
 
 /* This function is always expected to succeed */
-extern struct cifs_tcon *cifs_sb_master_tcon(struct cifs_sb_info *cifs_sb);
 
 #define CIFS_OPLOCK_NO_CHANGE 0xfe
 
@@ -1523,16 +1517,6 @@ cifsFileInfo_get_locked(struct cifsFileInfo *cifs_file)
 	++cifs_file->count;
 }
 
-struct cifsFileInfo *cifsFileInfo_get(struct cifsFileInfo *cifs_file);
-void _cifsFileInfo_put(struct cifsFileInfo *cifs_file, bool wait_oplock_hdlr,
-		       bool offload);
-void cifsFileInfo_put(struct cifsFileInfo *cifs_file);
-int cifs_file_flush(const unsigned int xid, struct inode *inode,
-		    struct cifsFileInfo *cfile);
-int cifs_file_set_size(const unsigned int xid, struct dentry *dentry,
-		       const char *full_path, struct cifsFileInfo *open_file,
-		       loff_t size);
-
 #define CIFS_CACHE_READ_FLG	1
 #define CIFS_CACHE_HANDLE_FLG	2
 #define CIFS_CACHE_RH_FLG	(CIFS_CACHE_READ_FLG | CIFS_CACHE_HANDLE_FLG)
@@ -1646,7 +1630,6 @@ static inline void cifs_stats_bytes_read(struct cifs_tcon *tcon,
 	spin_unlock(&tcon->stat_lock);
 }
 
-
 /*
  * This is the prototype for the mid receive function. This function is for
  * receiving the rest of the SMB frame, starting with the WordCount (which is
@@ -1853,7 +1836,6 @@ static inline bool is_replayable_error(int error)
 	return false;
 }
 
-
 /* cifs_get_writable_file() flags */
 enum cifs_writable_file_flags {
 	FIND_WR_ANY			= 0U,
@@ -2088,10 +2070,6 @@ extern unsigned int dir_cache_timeout; /* max time for directory lease caching o
 extern bool disable_legacy_dialects;  /* forbid vers=1.0 and vers=2.0 mounts */
 extern atomic_t mid_count;
 
-void cifs_oplock_break(struct work_struct *work);
-void cifs_queue_oplock_break(struct cifsFileInfo *cfile);
-void smb2_deferred_work_close(struct work_struct *work);
-
 extern const struct slow_work_ops cifs_oplock_break_ops;
 extern struct workqueue_struct *cifsiod_wq;
 extern struct workqueue_struct *decrypt_wq;
diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
index 49f35cb3cf2e..19a463d55fbf 100644
--- a/fs/smb/client/cifspdu.h
+++ b/fs/smb/client/cifspdu.h
@@ -577,10 +577,8 @@ struct ntlmv2_resp {
 	/* array of name entries could follow ending in minimum 4 byte struct */
 } __packed;
 
-
 #define CIFS_NETWORK_OPSYS "CIFS VFS Client for Linux"
 
-
 /*
  * Capabilities bits (for NTLM SessSetup request)
  * See MS-CIFS 2.2.4.52.2
@@ -636,7 +634,6 @@ typedef struct smb_com_tconx_rsp_ext {
 	/* STRING NativeFileSystem */
 } __packed TCONX_RSP_EXT;
 
-
 /* tree connect Flags */
 #define DISCONNECT_TID          0x0001
 #define TCON_EXTENDED_SIGNATURES 0x0004
@@ -836,7 +833,6 @@ typedef struct smb_com_open_rsp_ext {
 	__u16 ByteCount;        /* bct = 0 */
 } __packed OPEN_RSP_EXT;
 
-
 /* format of legacy open request */
 typedef struct smb_com_openx_req {
 	struct smb_hdr	hdr;	/* wct = 15 */
@@ -1293,7 +1289,6 @@ typedef struct smb_com_transaction_qsec_req {
 	__le32 AclFlags;
 } __packed QUERY_SEC_DESC_REQ;
 
-
 typedef struct smb_com_transaction_ssec_req {
 	struct smb_hdr hdr;     /* wct = 19 */
 	__u8 MaxSetupCount;
@@ -1488,7 +1483,6 @@ struct smb_t2_rsp {
 #define SMB_QUERY_FILE_MODE_INFO        0x3f8
 #define SMB_QUERY_FILE_ALGN_INFO        0x3f9
 
-
 #define SMB_SET_FILE_BASIC_INFO	        0x101
 #define SMB_SET_FILE_DISPOSITION_INFO   0x102
 #define SMB_SET_FILE_ALLOCATION_INFO    0x103
@@ -2031,7 +2025,6 @@ typedef struct {
 #define CIFS_UNIX_CAP_MASK              0x00000013
 #endif /* CONFIG_CIFS_POSIX */
 
-
 #define CIFS_POSIX_EXTENSIONS           0x00000010 /* support for new QFSInfo */
 
 /* DeviceType Flags */
@@ -2103,7 +2096,6 @@ typedef struct {
 	__u16 Pad;
 } __packed FILE_STANDARD_INFO;	/* level 0x102 QPathInfo */
 
-
 /* defines for enumerating possible values of the Unix type field below */
 #define UNIX_FILE      0
 #define UNIX_DIR       1
@@ -2278,7 +2270,6 @@ struct file_attrib_tag {
 	__le32 ReparseTag;
 } __packed;      /* level 0x40b */
 
-
 /********************************************************/
 /*  FindFirst/FindNext transact2 data buffer formats    */
 /********************************************************/
@@ -2308,7 +2299,6 @@ typedef struct {
 	char FileName[];
 } __packed FIND_FILE_STANDARD_INFO; /* level 0x1 FF resp data */
 
-
 struct fea {
 	unsigned char EA_flags;
 	__u8 name_len;
@@ -2331,7 +2321,6 @@ struct data_blob {
 	void (*free) (struct data_blob *data_blob);
 } __packed;
 
-
 #ifdef CONFIG_CIFS_POSIX
 /*
 	For better POSIX semantics from Linux client, (even better
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index aaa9e4f70f79..16b9ad555793 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -19,20 +19,562 @@ struct statfs;
 struct smb_rqst;
 struct smb3_fs_context;
 
-/* PROTOTYPES */
-
-extern struct smb_hdr *cifs_buf_get(void);
-extern void cifs_buf_release(void *);
-extern struct smb_hdr *cifs_small_buf_get(void);
-extern void cifs_small_buf_release(void *);
-extern void free_rsp_buf(int, void *);
-extern int smb_send(struct TCP_Server_Info *, struct smb_hdr *,
-			unsigned int /* length */);
-extern int smb_send_kvec(struct TCP_Server_Info *server,
-			 struct msghdr *msg,
-			 size_t *sent);
-extern unsigned int _get_xid(void);
-extern void _free_xid(unsigned int);
+
+/*
+ * asn1.c
+ */
+int decode_negTokenInit(unsigned char *security_blob, int length,
+			struct TCP_Server_Info *server);
+int cifs_gssapi_this_mech(void *context, size_t hdrlen,
+			  unsigned char tag, const void *value, size_t vlen);
+int cifs_neg_token_init_mech_type(void *context, size_t hdrlen,
+				  unsigned char tag,
+				  const void *value, size_t vlen);
+
+/*
+ * cifsacl.c
+ */
+int sid_to_id(struct cifs_sb_info *cifs_sb, struct smb_sid *psid,
+	      struct cifs_fattr *fattr, uint sidtype);
+int init_cifs_idmap(void);
+void exit_cifs_idmap(void);
+unsigned int setup_authusers_ACE(struct smb_ace *pntace);
+unsigned int setup_special_mode_ACE(struct smb_ace *pntace,
+				    bool posix,
+				    __u64 nmode);
+unsigned int setup_special_user_owner_ACE(struct smb_ace *pntace);
+struct smb_ntsd *get_cifs_acl_by_fid(struct cifs_sb_info *cifs_sb,
+				     const struct cifs_fid *cifsfid, u32 *pacllen,
+				     u32 info);
+struct smb_ntsd *get_cifs_acl(struct cifs_sb_info *cifs_sb,
+			      struct inode *inode, const char *path,
+			      u32 *pacllen, u32 info);
+int set_cifs_acl(struct smb_ntsd *pnntsd, __u32 acllen,
+		 struct inode *inode, const char *path, int aclflag);
+int cifs_acl_to_fattr(struct cifs_sb_info *cifs_sb, struct cifs_fattr *fattr,
+		      struct inode *inode, bool mode_from_special_sid,
+		      const char *path, const struct cifs_fid *pfid);
+int id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
+			kuid_t uid, kgid_t gid);
+struct posix_acl *cifs_get_acl(struct mnt_idmap *idmap,
+			       struct dentry *dentry, int type);
+int cifs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
+		 struct posix_acl *acl, int type);
+
+/*
+ * cifsencrypt.c
+ */
+int __cifs_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
+			  char *signature, struct cifs_calc_sig_ctx *ctx);
+int cifs_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server,
+		   __u32 *pexpected_response_sequence_number);
+int cifs_sign_smbv(struct kvec *iov, int n_vec, struct TCP_Server_Info *server,
+		   __u32 *pexpected_response_sequence);
+int cifs_sign_smb(struct smb_hdr *cifs_pdu, struct TCP_Server_Info *server,
+		  __u32 *pexpected_response_sequence_number);
+int cifs_verify_signature(struct smb_rqst *rqst,
+			  struct TCP_Server_Info *server,
+			  __u32 expected_sequence_number);
+int setup_ntlmv2_rsp(struct cifs_ses *ses, const struct nls_table *nls_cp);
+int calc_seckey(struct cifs_ses *ses);
+void cifs_crypto_secmech_release(struct TCP_Server_Info *server);
+
+/*
+ * cifsfs.c
+ */
+void cifs_sb_active(struct super_block *sb);
+void cifs_sb_deactive(struct super_block *sb);
+struct dentry *cifs_smb3_do_mount(struct file_system_type *fs_type,
+				  int flags, struct smb3_fs_context *old_ctx);
+const char *cifs_get_link(struct dentry *dentry, struct inode *inode,
+			  struct delayed_call *done);
+ssize_t cifs_file_copychunk_range(unsigned int xid,
+				  struct file *src_file, loff_t off,
+				  struct file *dst_file, loff_t destoff,
+				  size_t len, unsigned int flags);
+
+/*
+ * cifsroot.c
+ */
+int __init cifs_root_data(char **dev, char **opts);
+
+/*
+ * cifs_spnego.c
+ */
+struct key *cifs_get_spnego_key(struct cifs_ses *sesInfo,
+				struct TCP_Server_Info *server);
+int init_cifs_spnego(void);
+void exit_cifs_spnego(void);
+
+/*
+ * cifs_unicode.c
+ */
+int cifs_remap(struct cifs_sb_info *cifs_sb);
+int cifs_from_utf16(char *to, const __le16 *from, int tolen, int fromlen,
+		    const struct nls_table *codepage, int map_type);
+int cifs_strtoUTF16(__le16 *to, const char *from, int len,
+		    const struct nls_table *codepage);
+int cifs_utf16_bytes(const __le16 *from, int maxbytes,
+		     const struct nls_table *codepage);
+char *cifs_strndup_from_utf16(const char *src, const int maxlen,
+			      const bool is_unicode, const struct nls_table *codepage);
+int cifsConvertToUTF16(__le16 *target, const char *source, int srclen,
+		       const struct nls_table *cp, int map_chars);
+__le16 *cifs_strndup_to_utf16(const char *src, const int maxlen, int *utf16_len,
+			      const struct nls_table *cp, int remap);
+
+/*
+ * connect.c
+ */
+void smb2_query_server_interfaces(struct work_struct *work);
+void cifs_signal_cifsd_for_reconnect(struct TCP_Server_Info *server,
+				     bool all_channels);
+void cifs_mark_tcp_ses_conns_for_reconnect(struct TCP_Server_Info *server,
+					   bool mark_smb_session);
+int cifs_reconnect(struct TCP_Server_Info *server, bool mark_smb_session);
+int cifs_read_from_socket(struct TCP_Server_Info *server, char *buf,
+			  unsigned int to_read);
+ssize_t cifs_discard_from_socket(struct TCP_Server_Info *server, size_t to_read);
+int cifs_read_iter_from_socket(struct TCP_Server_Info *server, struct iov_iter *iter,
+			       unsigned int to_read);
+void dequeue_mid(struct mid_q_entry *mid, bool malformed);
+int cifs_enable_signing(struct TCP_Server_Info *server, bool mnt_sign_required);
+int cifs_handle_standard(struct TCP_Server_Info *server, struct mid_q_entry *mid);
+int cifs_ipaddr_cmp(struct sockaddr *srcaddr, struct sockaddr *rhs);
+bool cifs_match_ipaddr(struct sockaddr *srcaddr, struct sockaddr *rhs);
+struct TCP_Server_Info *cifs_find_tcp_session(struct smb3_fs_context *ctx);
+void cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect);
+struct TCP_Server_Info *cifs_get_tcp_session(struct smb3_fs_context *ctx,
+					     struct TCP_Server_Info *primary_server);
+struct cifs_tcon *cifs_setup_ipc(struct cifs_ses *ses, bool seal);
+void __cifs_put_smb_ses(struct cifs_ses *ses);
+struct cifs_ses *cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx);
+void cifs_put_tcon(struct cifs_tcon *tcon, enum smb3_tcon_ref_trace trace);
+void cifs_put_tlink(struct tcon_link *tlink);
+int cifs_match_super(struct super_block *sb, void *data);
+void reset_cifs_unix_caps(unsigned int xid, struct cifs_tcon *tcon,
+			  struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx);
+int cifs_setup_cifs_sb(struct cifs_sb_info *cifs_sb);
+void cifs_mount_put_conns(struct cifs_mount_ctx *mnt_ctx);
+int cifs_mount_get_session(struct cifs_mount_ctx *mnt_ctx);
+int cifs_mount_get_tcon(struct cifs_mount_ctx *mnt_ctx);
+int cifs_is_path_remote(struct cifs_mount_ctx *mnt_ctx);
+int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx);
+int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx);
+int CIFSTCon(const unsigned int xid, struct cifs_ses *ses,
+	     const char *tree, struct cifs_tcon *tcon,
+	     const struct nls_table *nls_codepage);
+void cifs_umount(struct cifs_sb_info *cifs_sb);
+int cifs_negotiate_protocol(const unsigned int xid, struct cifs_ses *ses,
+			    struct TCP_Server_Info *server);
+int cifs_setup_session(const unsigned int xid, struct cifs_ses *ses,
+		       struct TCP_Server_Info *server,
+		       struct nls_table *nls_info);
+struct cifs_tcon *cifs_sb_master_tcon(struct cifs_sb_info *cifs_sb);
+struct tcon_link *cifs_sb_tlink(struct cifs_sb_info *cifs_sb);
+int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon);
+
+/*
+ * dir.c
+ */
+char *cifs_build_path_to_root(struct smb3_fs_context *ctx, struct cifs_sb_info *cifs_sb,
+			      struct cifs_tcon *tcon, int add_treename);
+const char *build_path_from_dentry(struct dentry *direntry, void *page);
+char *__build_path_from_dentry_optional_prefix(struct dentry *direntry, void *page,
+					       const char *tree, int tree_len,
+					       bool prefix);
+char *build_path_from_dentry_optional_prefix(struct dentry *direntry, void *page,
+					     bool prefix);
+int cifs_atomic_open(struct inode *inode, struct dentry *direntry,
+		     struct file *file, unsigned int oflags, umode_t mode);
+int cifs_create(struct mnt_idmap *idmap, struct inode *inode,
+		struct dentry *direntry, umode_t mode, bool excl);
+int cifs_mknod(struct mnt_idmap *idmap, struct inode *inode,
+	       struct dentry *direntry, umode_t mode, dev_t device_number);
+struct dentry *cifs_lookup(struct inode *parent_dir_inode, struct dentry *direntry,
+			   unsigned int flags);
+
+/*
+ * dns_resolve.c
+ */
+int dns_resolve_name(const char *dom, const char *name,
+		     size_t namelen, struct sockaddr *ip_addr);
+
+/*
+ * file.c
+ */
+void cifs_mark_open_files_invalid(struct cifs_tcon *tcon);
+int cifs_posix_open(const char *full_path, struct inode **pinode,
+		    struct super_block *sb, int mode, unsigned int f_flags,
+		    __u32 *poplock, __u16 *pnetfid, unsigned int xid);
+void cifs_down_write(struct rw_semaphore *sem);
+void serverclose_work(struct work_struct *work);
+struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid, struct file *file,
+				       struct tcon_link *tlink, __u32 oplock,
+				       const char *symlink_target);
+struct cifsFileInfo *cifsFileInfo_get(struct cifsFileInfo *cifs_file);
+void serverclose_work(struct work_struct *work);
+void cifsFileInfo_put(struct cifsFileInfo *cifs_file);
+void _cifsFileInfo_put(struct cifsFileInfo *cifs_file,
+		       bool wait_oplock_handler, bool offload);
+int cifs_file_flush(const unsigned int xid, struct inode *inode,
+		    struct cifsFileInfo *cfile);
+int cifs_open(struct inode *inode, struct file *file);
+void smb2_deferred_work_close(struct work_struct *work);
+int cifs_close(struct inode *inode, struct file *file);
+void cifs_reopen_persistent_handles(struct cifs_tcon *tcon);
+int cifs_closedir(struct inode *inode, struct file *file);
+void cifs_del_lock_waiters(struct cifsLockInfo *lock);
+bool cifs_find_lock_conflict(struct cifsFileInfo *cfile, __u64 offset, __u64 length,
+			     __u8 type, __u16 flags,
+			     struct cifsLockInfo **conf_lock, int rw_check);
+int cifs_push_mandatory_locks(struct cifsFileInfo *cfile);
+void cifs_move_llist(struct list_head *source, struct list_head *dest);
+int cifs_get_hardlink_path(struct cifs_tcon *tcon, struct inode *inode,
+			   struct file *file);
+void cifs_free_llist(struct list_head *llist);
+int cifs_unlock_range(struct cifsFileInfo *cfile, struct file_lock *flock,
+		      unsigned int xid);
+int cifs_flock(struct file *file, int cmd, struct file_lock *fl);
+int cifs_lock(struct file *file, int cmd, struct file_lock *flock);
+void cifs_write_subrequest_terminated(struct cifs_io_subrequest *wdata, ssize_t result);
+struct cifsFileInfo *find_readable_file(struct cifsInodeInfo *cifs_inode,
+					bool fsuid_only);
+int cifs_get_writable_file(struct cifsInodeInfo *cifs_inode, int flags,
+			   struct cifsFileInfo **ret_file);
+struct cifsFileInfo *find_writable_file(struct cifsInodeInfo *cifs_inode, int flags);
+int cifs_get_writable_path(struct cifs_tcon *tcon, const char *name,
+			   int flags,
+			   struct cifsFileInfo **ret_file);
+int cifs_get_readable_path(struct cifs_tcon *tcon, const char *name,
+			   struct cifsFileInfo **ret_file);
+int cifs_strict_fsync(struct file *file, loff_t start, loff_t end,
+		      int datasync);
+int cifs_fsync(struct file *file, loff_t start, loff_t end, int datasync);
+int cifs_flush(struct file *file, fl_owner_t id);
+ssize_t cifs_strict_writev(struct kiocb *iocb, struct iov_iter *from);
+ssize_t cifs_loose_read_iter(struct kiocb *iocb, struct iov_iter *iter);
+ssize_t cifs_file_write_iter(struct kiocb *iocb, struct iov_iter *from);
+ssize_t cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to);
+int cifs_file_strict_mmap_prepare(struct vm_area_desc *desc);
+int cifs_file_mmap_prepare(struct vm_area_desc *desc);
+bool is_size_safe_to_change(struct cifsInodeInfo *cifsInode, __u64 end_of_file,
+			    bool from_readdir);
+void cifs_oplock_break(struct work_struct *work);
+
+/*
+ * fs_context.c
+ */
+int smb3_fs_context_dup(struct smb3_fs_context *new_ctx, struct smb3_fs_context *ctx);
+int smb3_parse_opt(const char *options, const char *key, char **val);
+char *cifs_sanitize_prepath(char *prepath, gfp_t gfp);
+char *smb3_fs_context_fullpath(const struct smb3_fs_context *ctx, char dirsep);
+int smb3_parse_devname(const char *devname, struct smb3_fs_context *ctx);
+int smb3_sync_session_ctx_passwords(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses);
+int smb3_init_fs_context(struct fs_context *fc);
+void smb3_cleanup_fs_context_contents(struct smb3_fs_context *ctx);
+void smb3_cleanup_fs_context(struct smb3_fs_context *ctx);
+void smb3_update_mnt_flags(struct cifs_sb_info *cifs_sb);
+
+/*
+ * inode.c
+ */
+int cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr,
+			bool from_readdir);
+void cifs_fill_uniqueid(struct super_block *sb, struct cifs_fattr *fattr);
+void cifs_unix_basic_to_fattr(struct cifs_fattr *fattr, FILE_UNIX_BASIC_INFO *info,
+			      struct cifs_sb_info *cifs_sb);
+int cifs_get_inode_info_unix(struct inode **pinode,
+			     const unsigned char *full_path,
+			     struct super_block *sb, unsigned int xid);
+int cifs_get_inode_info_unix(struct inode **pinode,
+			     const unsigned char *full_path,
+			     struct super_block *sb, unsigned int xid);
+umode_t wire_mode_to_posix(u32 wire, bool is_dir);
+int cifs_get_inode_info(struct inode **inode,
+			const char *full_path,
+			struct cifs_open_info_data *data,
+			struct super_block *sb, int xid,
+			const struct cifs_fid *fid);
+int smb311_posix_get_inode_info(struct inode **inode,
+				const char *full_path,
+				struct cifs_open_info_data *data,
+				struct super_block *sb,
+				const unsigned int xid);
+struct inode *cifs_iget(struct super_block *sb, struct cifs_fattr *fattr);
+struct inode *cifs_root_iget(struct super_block *sb);
+int cifs_set_file_info(struct inode *inode, struct iattr *attrs, unsigned int xid,
+		       const char *full_path, __u32 dosattr);
+int cifs_rename_pending_delete(const char *full_path, struct dentry *dentry,
+			       const unsigned int xid);
+int cifs_unlink(struct inode *dir, struct dentry *dentry);
+struct dentry *cifs_mkdir(struct mnt_idmap *idmap, struct inode *inode,
+			  struct dentry *direntry, umode_t mode);
+int cifs_rmdir(struct inode *inode, struct dentry *direntry);
+int cifs_rename2(struct mnt_idmap *idmap, struct inode *source_dir,
+		 struct dentry *source_dentry, struct inode *target_dir,
+		 struct dentry *target_dentry, unsigned int flags);
+int cifs_revalidate_mapping(struct inode *inode);
+int cifs_zap_mapping(struct inode *inode);
+int cifs_revalidate_file_attr(struct file *filp);
+int cifs_revalidate_dentry_attr(struct dentry *dentry);
+int cifs_revalidate_file(struct file *filp);
+int cifs_revalidate_dentry(struct dentry *dentry);
+int cifs_getattr(struct mnt_idmap *idmap, const struct path *path,
+		 struct kstat *stat, u32 request_mask, unsigned int flags);
+int cifs_fiemap(struct inode *inode, struct fiemap_extent_info *fei, u64 start,
+		u64 len);
+void cifs_setsize(struct inode *inode, loff_t offset);
+int cifs_file_set_size(const unsigned int xid, struct dentry *dentry,
+		       const char *full_path, struct cifsFileInfo *open_file,
+		       loff_t size);
+int cifs_setattr(struct mnt_idmap *idmap, struct dentry *direntry,
+		 struct iattr *attrs);
+
+/*
+ * ioctl.c
+ */
+long cifs_ioctl(struct file *filep, unsigned int command, unsigned long arg);
+
+/*
+ * link.c
+ */
+bool couldbe_mf_symlink(const struct cifs_fattr *fattr);
+int check_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
+		     struct cifs_sb_info *cifs_sb, struct cifs_fattr *fattr,
+		     const unsigned char *path);
+int cifs_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
+			  struct cifs_sb_info *cifs_sb, const unsigned char *path,
+			  char *pbuf, unsigned int *pbytes_read);
+int cifs_create_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
+			   struct cifs_sb_info *cifs_sb, const unsigned char *path,
+			   char *pbuf, unsigned int *pbytes_written);
+int smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
+			  struct cifs_sb_info *cifs_sb, const unsigned char *path,
+			  char *pbuf, unsigned int *pbytes_read);
+int smb3_create_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
+			   struct cifs_sb_info *cifs_sb, const unsigned char *path,
+			   char *pbuf, unsigned int *pbytes_written);
+int cifs_hardlink(struct dentry *old_file, struct inode *inode,
+		  struct dentry *direntry);
+int cifs_symlink(struct mnt_idmap *idmap, struct inode *inode,
+		 struct dentry *direntry, const char *symname);
+
+/*
+ * misc.c
+ */
+unsigned int _get_xid(void);
+void _free_xid(unsigned int xid);
+struct cifs_ses *sesInfoAlloc(void);
+void sesInfoFree(struct cifs_ses *buf_to_free);
+struct cifs_tcon *tcon_info_alloc(bool dir_leases_enabled, enum smb3_tcon_ref_trace trace);
+void tconInfoFree(struct cifs_tcon *tcon, enum smb3_tcon_ref_trace trace);
+struct smb_hdr *cifs_buf_get(void);
+void cifs_buf_release(void *buf_to_free);
+struct smb_hdr *cifs_small_buf_get(void);
+void cifs_small_buf_release(void *buf_to_free);
+void free_rsp_buf(int resp_buftype, void *rsp);
+void header_assemble(struct smb_hdr *buffer, char smb_command,
+		     const struct cifs_tcon *treeCon, int word_count
+		     /* length of fixed section word count in two byte units  */);
+int checkSMB(char *buf, unsigned int total_read, struct TCP_Server_Info *server);
+bool is_valid_oplock_break(char *buffer, struct TCP_Server_Info *srv);
+void dump_smb(void *buf, int smb_buf_length);
+void cifs_autodisable_serverino(struct cifs_sb_info *cifs_sb);
+void cifs_set_oplock_level(struct cifsInodeInfo *cinode, __u32 oplock);
+int cifs_get_writer(struct cifsInodeInfo *cinode);
+void cifs_put_writer(struct cifsInodeInfo *cinode);
+void cifs_queue_oplock_break(struct cifsFileInfo *cfile);
+void cifs_done_oplock_break(struct cifsInodeInfo *cinode);
+bool backup_cred(struct cifs_sb_info *cifs_sb);
+void cifs_del_pending_open(struct cifs_pending_open *open);
+void cifs_add_pending_open_locked(struct cifs_fid *fid, struct tcon_link *tlink,
+				  struct cifs_pending_open *open);
+void cifs_add_pending_open(struct cifs_fid *fid, struct tcon_link *tlink,
+			   struct cifs_pending_open *open);
+bool cifs_is_deferred_close(struct cifsFileInfo *cfile, struct cifs_deferred_close **pdclose);
+void cifs_add_deferred_close(struct cifsFileInfo *cfile, struct cifs_deferred_close *dclose);
+void cifs_del_deferred_close(struct cifsFileInfo *cfile);
+void cifs_close_deferred_file(struct cifsInodeInfo *cifs_inode);
+void cifs_close_all_deferred_files(struct cifs_tcon *tcon);
+void cifs_close_deferred_file_under_dentry(struct cifs_tcon *tcon,
+					   struct dentry *dentry);
+void cifs_mark_open_handles_for_deleted_file(struct inode *inode,
+					     const char *path);
+int parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
+			unsigned int *num_of_nodes,
+			struct dfs_info3_param **target_nodes,
+			const struct nls_table *nls_codepage, int remap,
+			const char *searchName, bool is_unicode);
+int cifs_alloc_hash(const char *name, struct shash_desc **sdesc);
+void cifs_free_hash(struct shash_desc **sdesc);
+void extract_unc_hostname(const char *unc, const char **h, size_t *len);
+int copy_path_name(char *dst, const char *src);
+struct super_block *cifs_get_dfs_tcon_super(struct cifs_tcon *tcon);
+void cifs_put_tcp_super(struct super_block *sb);
+int match_target_ip(struct TCP_Server_Info *server,
+		    const char *host, size_t hostlen,
+		    bool *result);
+int cifs_update_super_prepath(struct cifs_sb_info *cifs_sb, char *prefix);
+#ifdef CONFIG_CIFS_DFS_UPCALL
+int cifs_inval_name_dfs_link_error(const unsigned int xid,
+				   struct cifs_tcon *tcon,
+				   struct cifs_sb_info *cifs_sb,
+				   const char *full_path,
+				   bool *islink);
+#endif
+int cifs_wait_for_server_reconnect(struct TCP_Server_Info *server, bool retry);
+
+/*
+ * namespace.c
+ */
+void cifs_release_automount_timer(void);
+char *cifs_build_devname(char *nodename, const char *prepath);
+struct vfsmount *cifs_d_automount(struct path *path);
+
+/*
+ * netmisc.c
+ */
+int cifs_convert_address(struct sockaddr *dst, const char *src, int len);
+void cifs_set_port(struct sockaddr *addr, const unsigned short int port);
+int map_smb_to_linux_error(char *buf, bool logErr);
+int map_and_check_smb_error(struct mid_q_entry *mid, bool logErr);
+unsigned int smbCalcSize(void *buf);
+struct timespec64 cifs_NTtimeToUnix(__le64 ntutc);
+u64 cifs_UnixTimeToNT(struct timespec64 t);
+struct timespec64 cnvrtDosUnixTm(__le16 le_date, __le16 le_time, int offset);
+
+/*
+ * readdir.c
+ */
+void cifs_dir_info_to_fattr(struct cifs_fattr *fattr, FILE_DIRECTORY_INFO *info,
+			    struct cifs_sb_info *cifs_sb);
+int cifs_readdir(struct file *file, struct dir_context *ctx);
+
+/*
+ * reparse.c
+ */
+int create_reparse_symlink(const unsigned int xid, struct inode *inode,
+			   struct dentry *dentry, struct cifs_tcon *tcon,
+			   const char *full_path, const char *symname);
+int mknod_reparse(unsigned int xid, struct inode *inode,
+		  struct dentry *dentry, struct cifs_tcon *tcon,
+		  const char *full_path, umode_t mode, dev_t dev);
+int smb2_parse_native_symlink(char **target, const char *buf, unsigned int len,
+			      bool relative,
+			      const char *full_path,
+			      struct cifs_sb_info *cifs_sb);
+int parse_reparse_point(struct reparse_data_buffer *buf,
+			u32 plen, struct cifs_sb_info *cifs_sb,
+			const char *full_path,
+			struct cifs_open_info_data *data);
+struct reparse_data_buffer *smb2_get_reparse_point_buffer(const struct kvec *rsp_iov,
+							  u32 *plen);
+bool cifs_reparse_point_to_fattr(struct cifs_sb_info *cifs_sb,
+				 struct cifs_fattr *fattr,
+				 struct cifs_open_info_data *data);
+
+/*
+ * sess.c
+ */
+bool is_ses_using_iface(struct cifs_ses *ses, struct cifs_server_iface *iface);
+int cifs_ses_get_chan_index(struct cifs_ses *ses,
+			    struct TCP_Server_Info *server);
+void cifs_chan_set_in_reconnect(struct cifs_ses *ses,
+				struct TCP_Server_Info *server);
+void cifs_chan_clear_in_reconnect(struct cifs_ses *ses,
+				  struct TCP_Server_Info *server);
+void cifs_chan_set_need_reconnect(struct cifs_ses *ses,
+				  struct TCP_Server_Info *server);
+void cifs_chan_clear_need_reconnect(struct cifs_ses *ses,
+				    struct TCP_Server_Info *server);
+bool cifs_chan_needs_reconnect(struct cifs_ses *ses,
+			       struct TCP_Server_Info *server);
+bool cifs_chan_is_iface_active(struct cifs_ses *ses,
+			       struct TCP_Server_Info *server);
+int cifs_try_adding_channels(struct cifs_ses *ses);
+void cifs_disable_secondary_channels(struct cifs_ses *ses);
+void cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server);
+int decode_ntlmssp_challenge(char *bcc_ptr, int blob_len,
+			     struct cifs_ses *ses);
+int build_ntlmssp_negotiate_blob(unsigned char **pbuffer,
+				 u16 *buflen,
+				 struct cifs_ses *ses,
+				 struct TCP_Server_Info *server,
+				 const struct nls_table *nls_cp);
+int build_ntlmssp_smb3_negotiate_blob(unsigned char **pbuffer,
+				      u16 *buflen,
+				      struct cifs_ses *ses,
+				      struct TCP_Server_Info *server,
+				      const struct nls_table *nls_cp);
+int build_ntlmssp_auth_blob(unsigned char **pbuffer,
+			    u16 *buflen,
+			    struct cifs_ses *ses,
+			    struct TCP_Server_Info *server,
+			    const struct nls_table *nls_cp);
+enum securityEnum cifs_select_sectype(struct TCP_Server_Info *server, enum securityEnum requested);
+int CIFS_SessSetup(const unsigned int xid, struct cifs_ses *ses,
+		   struct TCP_Server_Info *server,
+		   const struct nls_table *nls_cp);
+
+/*
+ * smbencrypt.c
+ */
+int E_md4hash(const unsigned char *passwd, unsigned char *p16,
+	      const struct nls_table *codepage);
+
+/*
+ * transport.c
+ */
+void cifs_wake_up_task(struct mid_q_entry *mid);
+void __release_mid(struct kref *refcount);
+void delete_mid(struct mid_q_entry *mid);
+int smb_send_kvec(struct TCP_Server_Info *server, struct msghdr *smb_msg,
+		  size_t *sent);
+unsigned long smb_rqst_len(struct TCP_Server_Info *server, struct smb_rqst *rqst);
+int __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
+		    struct smb_rqst *rqst);
+int wait_for_free_request(struct TCP_Server_Info *server, const int flags,
+			  unsigned int *instance);
+int cifs_wait_mtu_credits(struct TCP_Server_Info *server, size_t size,
+			  size_t *num, struct cifs_credits *credits);
+int wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ);
+int cifs_call_async(struct TCP_Server_Info *server, struct smb_rqst *rqst,
+		    mid_receive_t *receive, mid_callback_t *callback,
+		    mid_handle_t *handle, void *cbdata, const int flags,
+		    const struct cifs_credits *exist_credits);
+int cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server);
+struct TCP_Server_Info *cifs_pick_channel(struct cifs_ses *ses);
+int compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
+		       struct TCP_Server_Info *server,
+		       const int flags, const int num_rqst, struct smb_rqst *rqst,
+		       int *resp_buf_type, struct kvec *resp_iov);
+int cifs_send_recv(const unsigned int xid, struct cifs_ses *ses,
+		   struct TCP_Server_Info *server,
+		   struct smb_rqst *rqst, int *resp_buf_type, const int flags,
+		   struct kvec *resp_iov);
+int cifs_discard_remaining_data(struct TCP_Server_Info *server);
+int cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid);
+
+/*
+ * unc.c
+ */
+char *extract_hostname(const char *unc);
+char *extract_sharename(const char *unc);
+
+/*
+ * winucase.c
+ */
+wchar_t cifs_toupper(wchar_t in);
+wchar_t cifs_toupper(wchar_t in);
+
+/*
+ * xattr.c
+ */
+#ifdef CONFIG_CIFS_XATTR
+ssize_t cifs_listxattr(struct dentry *direntry, char *data, size_t buf_size);
+#endif
+
 #define get_xid()							\
 ({									\
 	unsigned int __xid = _get_xid();				\
@@ -53,16 +595,6 @@ do {									\
 	else								\
 		trace_smb3_exit_done(curr_xid, __func__);		\
 } while (0)
-extern int init_cifs_idmap(void);
-extern void exit_cifs_idmap(void);
-extern int init_cifs_spnego(void);
-extern void exit_cifs_spnego(void);
-extern const char *build_path_from_dentry(struct dentry *, void *);
-char *__build_path_from_dentry_optional_prefix(struct dentry *direntry, void *page,
-					       const char *tree, int tree_len,
-					       bool prefix);
-extern char *build_path_from_dentry_optional_prefix(struct dentry *direntry,
-						    void *page, bool prefix);
 static inline void *alloc_dentry_path(void)
 {
 	return __getname();
@@ -74,61 +606,6 @@ static inline void free_dentry_path(void *page)
 		__putname(page);
 }
 
-extern char *cifs_build_path_to_root(struct smb3_fs_context *ctx,
-				     struct cifs_sb_info *cifs_sb,
-				     struct cifs_tcon *tcon,
-				     int add_treename);
-extern char *build_wildcard_path_from_dentry(struct dentry *direntry);
-char *cifs_build_devname(char *nodename, const char *prepath);
-extern void delete_mid(struct mid_q_entry *mid);
-void __release_mid(struct kref *refcount);
-extern void cifs_wake_up_task(struct mid_q_entry *mid);
-extern int cifs_handle_standard(struct TCP_Server_Info *server,
-				struct mid_q_entry *mid);
-extern char *smb3_fs_context_fullpath(const struct smb3_fs_context *ctx,
-				      char dirsep);
-extern int smb3_parse_devname(const char *devname, struct smb3_fs_context *ctx);
-extern int smb3_parse_opt(const char *options, const char *key, char **val);
-extern int cifs_ipaddr_cmp(struct sockaddr *srcaddr, struct sockaddr *rhs);
-extern bool cifs_match_ipaddr(struct sockaddr *srcaddr, struct sockaddr *rhs);
-extern int cifs_discard_remaining_data(struct TCP_Server_Info *server);
-extern int cifs_call_async(struct TCP_Server_Info *server,
-			struct smb_rqst *rqst,
-			mid_receive_t *receive, mid_callback_t *callback,
-			mid_handle_t *handle, void *cbdata, const int flags,
-			const struct cifs_credits *exist_credits);
-extern struct TCP_Server_Info *cifs_pick_channel(struct cifs_ses *ses);
-extern int cifs_send_recv(const unsigned int xid, struct cifs_ses *ses,
-			  struct TCP_Server_Info *server,
-			  struct smb_rqst *rqst, int *resp_buf_type,
-			  const int flags, struct kvec *resp_iov);
-extern int compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
-			      struct TCP_Server_Info *server,
-			      const int flags, const int num_rqst,
-			      struct smb_rqst *rqst, int *resp_buf_type,
-			      struct kvec *resp_iov);
-extern int SendReceive(const unsigned int /* xid */ , struct cifs_ses *,
-			struct smb_hdr * /* input */ ,
-			struct smb_hdr * /* out */ ,
-			int * /* bytes returned */ , const int);
-extern int SendReceiveNoRsp(const unsigned int xid, struct cifs_ses *ses,
-			    char *in_buf, int flags);
-int cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server);
-extern struct mid_q_entry *cifs_setup_request(struct cifs_ses *,
-				struct TCP_Server_Info *,
-				struct smb_rqst *);
-extern struct mid_q_entry *cifs_setup_async_request(struct TCP_Server_Info *,
-						struct smb_rqst *);
-int __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
-		    struct smb_rqst *rqst);
-extern int cifs_check_receive(struct mid_q_entry *mid,
-			struct TCP_Server_Info *server, bool log_error);
-int wait_for_free_request(struct TCP_Server_Info *server, const int flags,
-			  unsigned int *instance);
-extern int cifs_wait_mtu_credits(struct TCP_Server_Info *server,
-				 size_t size, size_t *num,
-				 struct cifs_credits *credits);
-
 static inline int
 send_cancel(struct TCP_Server_Info *server, struct smb_rqst *rqst,
 	    struct mid_q_entry *mid)
@@ -137,299 +614,6 @@ send_cancel(struct TCP_Server_Info *server, struct smb_rqst *rqst,
 				server->ops->send_cancel(server, rqst, mid) : 0;
 }
 
-int wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ);
-extern int SendReceive2(const unsigned int /* xid */ , struct cifs_ses *,
-			struct kvec *, int /* nvec to send */,
-			int * /* type of buf returned */, const int flags,
-			struct kvec * /* resp vec */);
-extern int SendReceiveBlockingLock(const unsigned int xid,
-			struct cifs_tcon *ptcon,
-			struct smb_hdr *in_buf,
-			struct smb_hdr *out_buf,
-			int *bytes_returned);
-
-void smb2_query_server_interfaces(struct work_struct *work);
-void
-cifs_signal_cifsd_for_reconnect(struct TCP_Server_Info *server,
-				      bool all_channels);
-void
-cifs_mark_tcp_ses_conns_for_reconnect(struct TCP_Server_Info *server,
-				      bool mark_smb_session);
-extern int cifs_reconnect(struct TCP_Server_Info *server,
-			  bool mark_smb_session);
-extern int checkSMB(char *buf, unsigned int len, struct TCP_Server_Info *srvr);
-extern bool is_valid_oplock_break(char *, struct TCP_Server_Info *);
-extern bool backup_cred(struct cifs_sb_info *);
-extern bool is_size_safe_to_change(struct cifsInodeInfo *cifsInode, __u64 eof,
-				   bool from_readdir);
-extern void cifs_update_eof(struct cifsInodeInfo *cifsi, loff_t offset,
-			    unsigned int bytes_written);
-void cifs_write_subrequest_terminated(struct cifs_io_subrequest *wdata, ssize_t result);
-extern struct cifsFileInfo *find_writable_file(struct cifsInodeInfo *, int);
-extern int cifs_get_writable_file(struct cifsInodeInfo *cifs_inode,
-				  int flags,
-				  struct cifsFileInfo **ret_file);
-extern int cifs_get_writable_path(struct cifs_tcon *tcon, const char *name,
-				  int flags,
-				  struct cifsFileInfo **ret_file);
-extern struct cifsFileInfo *find_readable_file(struct cifsInodeInfo *, bool);
-extern int cifs_get_readable_path(struct cifs_tcon *tcon, const char *name,
-				  struct cifsFileInfo **ret_file);
-extern int cifs_get_hardlink_path(struct cifs_tcon *tcon, struct inode *inode,
-				  struct file *file);
-extern unsigned int smbCalcSize(void *buf);
-extern int decode_negTokenInit(unsigned char *security_blob, int length,
-			struct TCP_Server_Info *server);
-extern int cifs_convert_address(struct sockaddr *dst, const char *src, int len);
-extern void cifs_set_port(struct sockaddr *addr, const unsigned short int port);
-extern int map_smb_to_linux_error(char *buf, bool logErr);
-extern int map_and_check_smb_error(struct mid_q_entry *mid, bool logErr);
-extern void header_assemble(struct smb_hdr *, char /* command */ ,
-			    const struct cifs_tcon *, int /* length of
-			    fixed section (word count) in two byte units */);
-extern int small_smb_init_no_tc(const int smb_cmd, const int wct,
-				struct cifs_ses *ses,
-				void **request_buf);
-extern enum securityEnum select_sectype(struct TCP_Server_Info *server,
-				enum securityEnum requested);
-extern int CIFS_SessSetup(const unsigned int xid, struct cifs_ses *ses,
-			  struct TCP_Server_Info *server,
-			  const struct nls_table *nls_cp);
-extern struct timespec64 cifs_NTtimeToUnix(__le64 utc_nanoseconds_since_1601);
-extern u64 cifs_UnixTimeToNT(struct timespec64);
-extern struct timespec64 cnvrtDosUnixTm(__le16 le_date, __le16 le_time,
-				      int offset);
-extern void cifs_set_oplock_level(struct cifsInodeInfo *cinode, __u32 oplock);
-extern int cifs_get_writer(struct cifsInodeInfo *cinode);
-extern void cifs_put_writer(struct cifsInodeInfo *cinode);
-extern void cifs_done_oplock_break(struct cifsInodeInfo *cinode);
-extern int cifs_unlock_range(struct cifsFileInfo *cfile,
-			     struct file_lock *flock, const unsigned int xid);
-extern int cifs_push_mandatory_locks(struct cifsFileInfo *cfile);
-
-extern void cifs_down_write(struct rw_semaphore *sem);
-struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid, struct file *file,
-				       struct tcon_link *tlink, __u32 oplock,
-				       const char *symlink_target);
-extern int cifs_posix_open(const char *full_path, struct inode **inode,
-			   struct super_block *sb, int mode,
-			   unsigned int f_flags, __u32 *oplock, __u16 *netfid,
-			   unsigned int xid);
-void cifs_fill_uniqueid(struct super_block *sb, struct cifs_fattr *fattr);
-extern void cifs_unix_basic_to_fattr(struct cifs_fattr *fattr,
-				     FILE_UNIX_BASIC_INFO *info,
-				     struct cifs_sb_info *cifs_sb);
-extern void cifs_dir_info_to_fattr(struct cifs_fattr *, FILE_DIRECTORY_INFO *,
-					struct cifs_sb_info *);
-extern int cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr,
-			       bool from_readdir);
-extern struct inode *cifs_iget(struct super_block *sb,
-			       struct cifs_fattr *fattr);
-
-int cifs_get_inode_info(struct inode **inode, const char *full_path,
-			struct cifs_open_info_data *data, struct super_block *sb, int xid,
-			const struct cifs_fid *fid);
-extern int smb311_posix_get_inode_info(struct inode **inode,
-				       const char *full_path,
-				       struct cifs_open_info_data *data,
-				       struct super_block *sb,
-				       const unsigned int xid);
-extern int cifs_get_inode_info_unix(struct inode **pinode,
-			const unsigned char *search_path,
-			struct super_block *sb, unsigned int xid);
-extern int cifs_set_file_info(struct inode *inode, struct iattr *attrs,
-			      unsigned int xid, const char *full_path, __u32 dosattr);
-extern int cifs_rename_pending_delete(const char *full_path,
-				      struct dentry *dentry,
-				      const unsigned int xid);
-extern int sid_to_id(struct cifs_sb_info *cifs_sb, struct smb_sid *psid,
-				struct cifs_fattr *fattr, uint sidtype);
-extern int cifs_acl_to_fattr(struct cifs_sb_info *cifs_sb,
-			      struct cifs_fattr *fattr, struct inode *inode,
-			      bool get_mode_from_special_sid,
-			      const char *path, const struct cifs_fid *pfid);
-extern int id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
-					kuid_t uid, kgid_t gid);
-extern struct smb_ntsd *get_cifs_acl(struct cifs_sb_info *cifssmb, struct inode *ino,
-				      const char *path, u32 *plen, u32 info);
-extern struct smb_ntsd *get_cifs_acl_by_fid(struct cifs_sb_info *cifssb,
-				const struct cifs_fid *pfid, u32 *plen, u32 info);
-extern struct posix_acl *cifs_get_acl(struct mnt_idmap *idmap,
-				      struct dentry *dentry, int type);
-extern int cifs_set_acl(struct mnt_idmap *idmap,
-			struct dentry *dentry, struct posix_acl *acl, int type);
-extern int set_cifs_acl(struct smb_ntsd *pntsd, __u32 len, struct inode *ino,
-				const char *path, int flag);
-extern unsigned int setup_authusers_ACE(struct smb_ace *pace);
-extern unsigned int setup_special_mode_ACE(struct smb_ace *pace,
-					   bool posix,
-					   __u64 nmode);
-extern unsigned int setup_special_user_owner_ACE(struct smb_ace *pace);
-
-extern void dequeue_mid(struct mid_q_entry *mid, bool malformed);
-extern int cifs_read_from_socket(struct TCP_Server_Info *server, char *buf,
-			         unsigned int to_read);
-extern ssize_t cifs_discard_from_socket(struct TCP_Server_Info *server,
-					size_t to_read);
-int cifs_read_iter_from_socket(struct TCP_Server_Info *server,
-			       struct iov_iter *iter,
-			       unsigned int to_read);
-extern int cifs_setup_cifs_sb(struct cifs_sb_info *cifs_sb);
-void cifs_mount_put_conns(struct cifs_mount_ctx *mnt_ctx);
-int cifs_mount_get_session(struct cifs_mount_ctx *mnt_ctx);
-int cifs_is_path_remote(struct cifs_mount_ctx *mnt_ctx);
-int cifs_mount_get_tcon(struct cifs_mount_ctx *mnt_ctx);
-extern int cifs_match_super(struct super_block *, void *);
-extern int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx);
-extern void cifs_umount(struct cifs_sb_info *);
-extern void cifs_mark_open_files_invalid(struct cifs_tcon *tcon);
-extern void cifs_reopen_persistent_handles(struct cifs_tcon *tcon);
-
-extern bool cifs_find_lock_conflict(struct cifsFileInfo *cfile, __u64 offset,
-				    __u64 length, __u8 type, __u16 flags,
-				    struct cifsLockInfo **conf_lock,
-				    int rw_check);
-extern void cifs_add_pending_open(struct cifs_fid *fid,
-				  struct tcon_link *tlink,
-				  struct cifs_pending_open *open);
-extern void cifs_add_pending_open_locked(struct cifs_fid *fid,
-					 struct tcon_link *tlink,
-					 struct cifs_pending_open *open);
-extern void cifs_del_pending_open(struct cifs_pending_open *open);
-
-extern bool cifs_is_deferred_close(struct cifsFileInfo *cfile,
-				struct cifs_deferred_close **dclose);
-
-extern void cifs_add_deferred_close(struct cifsFileInfo *cfile,
-				struct cifs_deferred_close *dclose);
-
-extern void cifs_del_deferred_close(struct cifsFileInfo *cfile);
-
-extern void cifs_close_deferred_file(struct cifsInodeInfo *cifs_inode);
-
-extern void cifs_close_all_deferred_files(struct cifs_tcon *cifs_tcon);
-
-void cifs_close_deferred_file_under_dentry(struct cifs_tcon *cifs_tcon,
-					   struct dentry *dentry);
-
-extern void cifs_mark_open_handles_for_deleted_file(struct inode *inode,
-				const char *path);
-
-extern struct TCP_Server_Info *
-cifs_get_tcp_session(struct smb3_fs_context *ctx,
-		     struct TCP_Server_Info *primary_server);
-extern void cifs_put_tcp_session(struct TCP_Server_Info *server,
-				 int from_reconnect);
-extern void cifs_put_tcon(struct cifs_tcon *tcon, enum smb3_tcon_ref_trace trace);
-
-extern void cifs_release_automount_timer(void);
-
-void cifs_proc_init(void);
-void cifs_proc_clean(void);
-
-extern void cifs_move_llist(struct list_head *source, struct list_head *dest);
-extern void cifs_free_llist(struct list_head *llist);
-extern void cifs_del_lock_waiters(struct cifsLockInfo *lock);
-
-int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon);
-
-extern int cifs_negotiate_protocol(const unsigned int xid,
-				   struct cifs_ses *ses,
-				   struct TCP_Server_Info *server);
-extern int cifs_setup_session(const unsigned int xid, struct cifs_ses *ses,
-			      struct TCP_Server_Info *server,
-			      struct nls_table *nls_info);
-extern int cifs_enable_signing(struct TCP_Server_Info *server, bool mnt_sign_required);
-extern int CIFSSMBNegotiate(const unsigned int xid,
-			    struct cifs_ses *ses,
-			    struct TCP_Server_Info *server);
-
-extern int CIFSTCon(const unsigned int xid, struct cifs_ses *ses,
-		    const char *tree, struct cifs_tcon *tcon,
-		    const struct nls_table *);
-
-extern int CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
-		const char *searchName, struct cifs_sb_info *cifs_sb,
-		__u16 *searchHandle, __u16 search_flags,
-		struct cifs_search_info *psrch_inf,
-		bool msearch);
-
-extern int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
-		__u16 searchHandle, __u16 search_flags,
-		struct cifs_search_info *psrch_inf);
-
-extern int CIFSFindClose(const unsigned int xid, struct cifs_tcon *tcon,
-			const __u16 search_handle);
-
-extern int CIFSSMBQFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
-			u16 netfid, FILE_ALL_INFO *pFindData);
-extern int CIFSSMBQPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
-			    const char *search_Name, FILE_ALL_INFO *data,
-			    int legacy /* whether to use old info level */,
-			    const struct nls_table *nls_codepage, int remap);
-extern int SMBQueryInformation(const unsigned int xid, struct cifs_tcon *tcon,
-			       const char *search_name, FILE_ALL_INFO *data,
-			       const struct nls_table *nls_codepage, int remap);
-
-extern int CIFSSMBUnixQFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
-			u16 netfid, FILE_UNIX_BASIC_INFO *pFindData);
-extern int CIFSSMBUnixQPathInfo(const unsigned int xid,
-			struct cifs_tcon *tcon,
-			const unsigned char *searchName,
-			FILE_UNIX_BASIC_INFO *pFindData,
-			const struct nls_table *nls_codepage, int remap);
-
-extern int CIFSGetDFSRefer(const unsigned int xid, struct cifs_ses *ses,
-			   const char *search_name,
-			   struct dfs_info3_param **target_nodes,
-			   unsigned int *num_of_nodes,
-			   const struct nls_table *nls_codepage, int remap);
-
-extern int parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
-			       unsigned int *num_of_nodes,
-			       struct dfs_info3_param **target_nodes,
-			       const struct nls_table *nls_codepage, int remap,
-			       const char *searchName, bool is_unicode);
-extern void reset_cifs_unix_caps(unsigned int xid, struct cifs_tcon *tcon,
-				 struct cifs_sb_info *cifs_sb,
-				 struct smb3_fs_context *ctx);
-extern int CIFSSMBQFSInfo(const unsigned int xid, struct cifs_tcon *tcon,
-			struct kstatfs *FSData);
-extern int SMBOldQFSInfo(const unsigned int xid, struct cifs_tcon *tcon,
-			struct kstatfs *FSData);
-extern int CIFSSMBSetFSUnixInfo(const unsigned int xid, struct cifs_tcon *tcon,
-			__u64 cap);
-
-extern int CIFSSMBQFSAttributeInfo(const unsigned int xid,
-			struct cifs_tcon *tcon);
-extern int CIFSSMBQFSDeviceInfo(const unsigned int xid, struct cifs_tcon *tcon);
-extern int CIFSSMBQFSUnixInfo(const unsigned int xid, struct cifs_tcon *tcon);
-extern int CIFSSMBQFSPosixInfo(const unsigned int xid, struct cifs_tcon *tcon,
-			struct kstatfs *FSData);
-
-extern int SMBSetInformation(const unsigned int xid, struct cifs_tcon *tcon,
-			     const char *fileName, __le32 attributes, __le64 write_time,
-			     const struct nls_table *nls_codepage,
-			     struct cifs_sb_info *cifs_sb);
-extern int CIFSSMBSetPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
-			const char *fileName, const FILE_BASIC_INFO *data,
-			const struct nls_table *nls_codepage,
-			struct cifs_sb_info *cifs_sb);
-extern int CIFSSMBSetFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
-			const FILE_BASIC_INFO *data, __u16 fid,
-			__u32 pid_of_opener);
-extern int CIFSSMBSetFileDisposition(const unsigned int xid,
-				     struct cifs_tcon *tcon,
-				     bool delete_file, __u16 fid,
-				     __u32 pid_of_opener);
-extern int CIFSSMBSetEOF(const unsigned int xid, struct cifs_tcon *tcon,
-			 const char *file_name, __u64 size,
-			 struct cifs_sb_info *cifs_sb, bool set_allocation,
-			 struct dentry *dentry);
-extern int CIFSSMBSetFileSize(const unsigned int xid, struct cifs_tcon *tcon,
-			      struct cifsFileInfo *cfile, __u64 size,
-			      bool set_allocation);
-
 struct cifs_unix_set_info_args {
 	__u64	ctime;
 	__u64	atime;
@@ -440,260 +624,8 @@ struct cifs_unix_set_info_args {
 	dev_t	device;
 };
 
-extern int CIFSSMBUnixSetFileInfo(const unsigned int xid,
-				  struct cifs_tcon *tcon,
-				  const struct cifs_unix_set_info_args *args,
-				  u16 fid, u32 pid_of_opener);
-
-extern int CIFSSMBUnixSetPathInfo(const unsigned int xid,
-				  struct cifs_tcon *tcon, const char *file_name,
-				  const struct cifs_unix_set_info_args *args,
-				  const struct nls_table *nls_codepage,
-				  int remap);
-
-extern int CIFSSMBMkDir(const unsigned int xid, struct inode *inode,
-			umode_t mode, struct cifs_tcon *tcon,
-			const char *name, struct cifs_sb_info *cifs_sb);
-extern int CIFSSMBRmDir(const unsigned int xid, struct cifs_tcon *tcon,
-			const char *name, struct cifs_sb_info *cifs_sb);
-extern int CIFSPOSIXDelFile(const unsigned int xid, struct cifs_tcon *tcon,
-			const char *name, __u16 type,
-			const struct nls_table *nls_codepage,
-			int remap_special_chars);
-extern int CIFSSMBDelFile(const unsigned int xid, struct cifs_tcon *tcon,
-			  const char *name, struct cifs_sb_info *cifs_sb,
-			  struct dentry *dentry);
-int CIFSSMBRename(const unsigned int xid, struct cifs_tcon *tcon,
-		  struct dentry *source_dentry,
-		  const char *from_name, const char *to_name,
-		  struct cifs_sb_info *cifs_sb);
-extern int CIFSSMBRenameOpenFile(const unsigned int xid, struct cifs_tcon *tcon,
-				 int netfid, const char *target_name,
-				 const struct nls_table *nls_codepage,
-				 int remap_special_chars);
-int CIFSCreateHardLink(const unsigned int xid,
-		       struct cifs_tcon *tcon,
-		       struct dentry *source_dentry,
-		       const char *from_name, const char *to_name,
-		       struct cifs_sb_info *cifs_sb);
-extern int CIFSUnixCreateHardLink(const unsigned int xid,
-			struct cifs_tcon *tcon,
-			const char *fromName, const char *toName,
-			const struct nls_table *nls_codepage,
-			int remap_special_chars);
-extern int CIFSUnixCreateSymLink(const unsigned int xid,
-			struct cifs_tcon *tcon,
-			const char *fromName, const char *toName,
-			const struct nls_table *nls_codepage, int remap);
-extern int CIFSSMBUnixQuerySymLink(const unsigned int xid,
-			struct cifs_tcon *tcon,
-			const unsigned char *searchName, char **syminfo,
-			const struct nls_table *nls_codepage, int remap);
-extern int cifs_query_reparse_point(const unsigned int xid,
-				    struct cifs_tcon *tcon,
-				    struct cifs_sb_info *cifs_sb,
-				    const char *full_path,
-				    u32 *tag, struct kvec *rsp,
-				    int *rsp_buftype);
-extern struct inode *cifs_create_reparse_inode(struct cifs_open_info_data *data,
-					       struct super_block *sb,
-					       const unsigned int xid,
-					       struct cifs_tcon *tcon,
-					       const char *full_path,
-					       bool directory,
-					       struct kvec *reparse_iov,
-					       struct kvec *xattr_iov);
-extern int CIFSSMB_set_compression(const unsigned int xid,
-				   struct cifs_tcon *tcon, __u16 fid);
-extern int CIFS_open(const unsigned int xid, struct cifs_open_parms *oparms,
-		     int *oplock, FILE_ALL_INFO *buf);
-extern int SMBLegacyOpen(const unsigned int xid, struct cifs_tcon *tcon,
-			const char *fileName, const int disposition,
-			const int access_flags, const int omode,
-			__u16 *netfid, int *pOplock, FILE_ALL_INFO *,
-			const struct nls_table *nls_codepage, int remap);
-extern int CIFSPOSIXCreate(const unsigned int xid, struct cifs_tcon *tcon,
-			u32 posix_flags, __u64 mode, __u16 *netfid,
-			FILE_UNIX_BASIC_INFO *pRetData,
-			__u32 *pOplock, const char *name,
-			const struct nls_table *nls_codepage, int remap);
-extern int CIFSSMBClose(const unsigned int xid, struct cifs_tcon *tcon,
-			const int smb_file_id);
-
-extern int CIFSSMBFlush(const unsigned int xid, struct cifs_tcon *tcon,
-			const int smb_file_id);
-
-extern int CIFSSMBRead(const unsigned int xid, struct cifs_io_parms *io_parms,
-			unsigned int *nbytes, char **buf,
-			int *return_buf_type);
-extern int CIFSSMBWrite(const unsigned int xid, struct cifs_io_parms *io_parms,
-			unsigned int *nbytes, const char *buf);
-extern int CIFSSMBWrite2(const unsigned int xid, struct cifs_io_parms *io_parms,
-			unsigned int *nbytes, struct kvec *iov, const int nvec);
-extern int CIFSGetSrvInodeNumber(const unsigned int xid, struct cifs_tcon *tcon,
-				 const char *search_name, __u64 *inode_number,
-				 const struct nls_table *nls_codepage,
-				 int remap);
-
-extern int cifs_lockv(const unsigned int xid, struct cifs_tcon *tcon,
-		      const __u16 netfid, const __u8 lock_type,
-		      const __u32 num_unlock, const __u32 num_lock,
-		      LOCKING_ANDX_RANGE *buf);
-extern int CIFSSMBLock(const unsigned int xid, struct cifs_tcon *tcon,
-			const __u16 netfid, const __u32 netpid, const __u64 len,
-			const __u64 offset, const __u32 numUnlock,
-			const __u32 numLock, const __u8 lockType,
-			const bool waitFlag, const __u8 oplock_level);
-extern int CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
-			const __u16 smb_file_id, const __u32 netpid,
-			const loff_t start_offset, const __u64 len,
-			struct file_lock *, const __u16 lock_type,
-			const bool waitFlag);
-extern int CIFSSMBTDis(const unsigned int xid, struct cifs_tcon *tcon);
-extern int CIFSSMBEcho(struct TCP_Server_Info *server);
-extern int CIFSSMBLogoff(const unsigned int xid, struct cifs_ses *ses);
-
-extern struct cifs_ses *sesInfoAlloc(void);
-extern void sesInfoFree(struct cifs_ses *);
-extern struct cifs_tcon *tcon_info_alloc(bool dir_leases_enabled,
-					 enum smb3_tcon_ref_trace trace);
-extern void tconInfoFree(struct cifs_tcon *tcon, enum smb3_tcon_ref_trace trace);
-
-extern int cifs_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server,
-		   __u32 *pexpected_response_sequence_number);
-extern int cifs_sign_smbv(struct kvec *iov, int n_vec, struct TCP_Server_Info *,
-			  __u32 *);
-extern int cifs_sign_smb(struct smb_hdr *, struct TCP_Server_Info *, __u32 *);
-extern int cifs_verify_signature(struct smb_rqst *rqst,
-				 struct TCP_Server_Info *server,
-				__u32 expected_sequence_number);
-extern int setup_ntlmv2_rsp(struct cifs_ses *, const struct nls_table *);
-extern void cifs_crypto_secmech_release(struct TCP_Server_Info *server);
-extern int calc_seckey(struct cifs_ses *);
-extern int generate_smb30signingkey(struct cifs_ses *ses,
-				    struct TCP_Server_Info *server);
-extern int generate_smb311signingkey(struct cifs_ses *ses,
-				     struct TCP_Server_Info *server);
-
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
-extern ssize_t CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
-			const unsigned char *searchName,
-			const unsigned char *ea_name, char *EAData,
-			size_t bufsize, struct cifs_sb_info *cifs_sb);
-extern int CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
-		const char *fileName, const char *ea_name,
-		const void *ea_value, const __u16 ea_value_len,
-		const struct nls_table *nls_codepage,
-		struct cifs_sb_info *cifs_sb);
-extern int CIFSSMBGetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon,
-			__u16 fid, struct smb_ntsd **acl_inf, __u32 *buflen, __u32 info);
-extern int CIFSSMBSetCIFSACL(const unsigned int, struct cifs_tcon *, __u16,
-			struct smb_ntsd *pntsd, __u32 len, int aclflag);
-extern int cifs_do_get_acl(const unsigned int xid, struct cifs_tcon *tcon,
-			   const unsigned char *searchName,
-			   struct posix_acl **acl, const int acl_type,
-			   const struct nls_table *nls_codepage, int remap);
-extern int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
-			   const unsigned char *fileName,
-			   const struct posix_acl *acl, const int acl_type,
-			   const struct nls_table *nls_codepage, int remap);
-extern int CIFSGetExtAttr(const unsigned int xid, struct cifs_tcon *tcon,
-			const int netfid, __u64 *pExtAttrBits, __u64 *pMask);
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
-extern void cifs_autodisable_serverino(struct cifs_sb_info *cifs_sb);
-extern bool couldbe_mf_symlink(const struct cifs_fattr *fattr);
-extern int check_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
-			      struct cifs_sb_info *cifs_sb,
-			      struct cifs_fattr *fattr,
-			      const unsigned char *path);
-extern int E_md4hash(const unsigned char *passwd, unsigned char *p16,
-			const struct nls_table *codepage);
-
-extern struct TCP_Server_Info *
-cifs_find_tcp_session(struct smb3_fs_context *ctx);
-
-struct cifs_tcon *cifs_setup_ipc(struct cifs_ses *ses, bool seal);
-
-void __cifs_put_smb_ses(struct cifs_ses *ses);
-
-extern struct cifs_ses *
-cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx);
-
-int cifs_async_readv(struct cifs_io_subrequest *rdata);
-int cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid);
-
-void cifs_async_writev(struct cifs_io_subrequest *wdata);
-int cifs_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
-			  struct cifs_sb_info *cifs_sb,
-			  const unsigned char *path, char *pbuf,
-			  unsigned int *pbytes_read);
-int cifs_create_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
-			   struct cifs_sb_info *cifs_sb,
-			   const unsigned char *path, char *pbuf,
-			   unsigned int *pbytes_written);
-int __cifs_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
-			  char *signature, struct cifs_calc_sig_ctx *ctx);
-enum securityEnum cifs_select_sectype(struct TCP_Server_Info *,
-					enum securityEnum);
-
-int cifs_alloc_hash(const char *name, struct shash_desc **sdesc);
-void cifs_free_hash(struct shash_desc **sdesc);
-
-int cifs_try_adding_channels(struct cifs_ses *ses);
-bool is_ses_using_iface(struct cifs_ses *ses, struct cifs_server_iface *iface);
-void cifs_ses_mark_for_reconnect(struct cifs_ses *ses);
-
-int
-cifs_ses_get_chan_index(struct cifs_ses *ses,
-			struct TCP_Server_Info *server);
-void
-cifs_chan_set_in_reconnect(struct cifs_ses *ses,
-			     struct TCP_Server_Info *server);
-void
-cifs_chan_clear_in_reconnect(struct cifs_ses *ses,
-			       struct TCP_Server_Info *server);
-void
-cifs_chan_set_need_reconnect(struct cifs_ses *ses,
-			     struct TCP_Server_Info *server);
-void
-cifs_chan_clear_need_reconnect(struct cifs_ses *ses,
-			       struct TCP_Server_Info *server);
-bool
-cifs_chan_needs_reconnect(struct cifs_ses *ses,
-			  struct TCP_Server_Info *server);
-bool
-cifs_chan_is_iface_active(struct cifs_ses *ses,
-			  struct TCP_Server_Info *server);
-void
-cifs_disable_secondary_channels(struct cifs_ses *ses);
-void
-cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server);
-int
-SMB3_request_interfaces(const unsigned int xid, struct cifs_tcon *tcon, bool in_mount);
-
-void extract_unc_hostname(const char *unc, const char **h, size_t *len);
-int copy_path_name(char *dst, const char *src);
-int smb2_parse_query_directory(struct cifs_tcon *tcon, struct kvec *rsp_iov,
-			       int resp_buftype,
-			       struct cifs_search_info *srch_inf);
-
-struct super_block *cifs_get_dfs_tcon_super(struct cifs_tcon *tcon);
-void cifs_put_tcp_super(struct super_block *sb);
-int cifs_update_super_prepath(struct cifs_sb_info *cifs_sb, char *prefix);
-char *extract_hostname(const char *unc);
-char *extract_sharename(const char *unc);
-int parse_reparse_point(struct reparse_data_buffer *buf,
-			u32 plen, struct cifs_sb_info *cifs_sb,
-			const char *full_path,
-			struct cifs_open_info_data *data);
-int __cifs_sfu_make_node(unsigned int xid, struct inode *inode,
-			 struct dentry *dentry, struct cifs_tcon *tcon,
-			 const char *full_path, umode_t mode, dev_t dev,
-			 const char *symname);
-int cifs_sfu_make_node(unsigned int xid, struct inode *inode,
-		       struct dentry *dentry, struct cifs_tcon *tcon,
-		       const char *full_path, umode_t mode, dev_t dev);
-umode_t wire_mode_to_posix(u32 wire, bool is_dir);
 
 #ifdef CONFIG_CIFS_DFS_UPCALL
 static inline int get_dfs_path(const unsigned int xid, struct cifs_ses *ses,
@@ -705,14 +637,6 @@ static inline int get_dfs_path(const unsigned int xid, struct cifs_ses *ses,
 			      referral, NULL);
 }
 
-int match_target_ip(struct TCP_Server_Info *server,
-		    const char *host, size_t hostlen,
-		    bool *result);
-int cifs_inval_name_dfs_link_error(const unsigned int xid,
-				   struct cifs_tcon *tcon,
-				   struct cifs_sb_info *cifs_sb,
-				   const char *full_path,
-				   bool *islink);
 #else
 static inline int cifs_inval_name_dfs_link_error(const unsigned int xid,
 				   struct cifs_tcon *tcon,
@@ -733,8 +657,6 @@ static inline int cifs_create_options(struct cifs_sb_info *cifs_sb, int options)
 		return options;
 }
 
-int cifs_wait_for_server_reconnect(struct TCP_Server_Info *server, bool retry);
-
 static inline void cifs_put_smb_ses(struct cifs_ses *ses)
 {
 	__cifs_put_smb_ses(ses);
diff --git a/fs/smb/client/compress.h b/fs/smb/client/compress.h
index d843274e2a3d..4f831ab30da7 100644
--- a/fs/smb/client/compress.h
+++ b/fs/smb/client/compress.h
@@ -29,10 +29,12 @@
 #ifdef CONFIG_CIFS_COMPRESSION
 typedef int (*compress_send_fn)(struct TCP_Server_Info *, int, struct smb_rqst *);
 
-/* PROTOTYPES */
 
-int smb_compress(struct TCP_Server_Info *server, struct smb_rqst *rq, compress_send_fn send_fn);
+/*
+ * compress.c
+ */
 bool should_compress(const struct cifs_tcon *tcon, const struct smb_rqst *rq);
+int smb_compress(struct TCP_Server_Info *server, struct smb_rqst *rq, compress_send_fn send_fn);
 
 /*
  * smb_compress_alg_valid() - Validate a compression algorithm.
diff --git a/fs/smb/client/dfs.h b/fs/smb/client/dfs.h
index 21e2c9fd62e6..8459d2525881 100644
--- a/fs/smb/client/dfs.h
+++ b/fs/smb/client/dfs.h
@@ -41,7 +41,14 @@ struct dfs_ref_walk {
 #define ref_walk_fpath(w)	(ref_walk_cur(w)->full_path)
 #define ref_walk_tl(w)		(&ref_walk_cur(w)->tl)
 #define ref_walk_ses(w)	(ref_walk_cur(w)->ses)
-/* PROTOTYPES */
+
+/*
+ * dfs.c
+ */
+int dfs_parse_target_referral(const char *full_path, const struct dfs_info3_param *ref,
+			      struct smb3_fs_context *ctx);
+int dfs_mount_share(struct cifs_mount_ctx *mnt_ctx);
+int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon);
 
 static inline struct dfs_ref_walk *ref_walk_alloc(void)
 {
@@ -152,10 +159,6 @@ static inline void ref_walk_mark_end(struct dfs_ref_walk *rw)
 	ref->tit = ERR_PTR(-ENOENT); /* end marker */
 }
 
-int dfs_parse_target_referral(const char *full_path, const struct dfs_info3_param *ref,
-			      struct smb3_fs_context *ctx);
-int dfs_mount_share(struct cifs_mount_ctx *mnt_ctx);
-
 static inline char *dfs_get_path(struct cifs_sb_info *cifs_sb, const char *path)
 {
 	return dfs_cache_canonical_path(path, cifs_sb->local_nls, cifs_remap(cifs_sb));
diff --git a/fs/smb/client/dfs_cache.h b/fs/smb/client/dfs_cache.h
index f311310a22fc..5900ef876297 100644
--- a/fs/smb/client/dfs_cache.h
+++ b/fs/smb/client/dfs_cache.h
@@ -32,12 +32,13 @@ struct dfs_cache_tgt_iterator {
 	int it_path_consumed;
 	struct list_head it_list;
 };
-/* PROTOTYPES */
 
+/*
+ * dfs_cache.c
+ */
+char *dfs_cache_canonical_path(const char *path, const struct nls_table *cp, int remap);
 int dfs_cache_init(void);
 void dfs_cache_destroy(void);
-extern const struct proc_ops dfscache_proc_ops;
-
 int dfs_cache_find(const unsigned int xid, struct cifs_ses *ses, const struct nls_table *cp,
 		   int remap, const char *path, struct dfs_info3_param *ref,
 		   struct dfs_cache_tgt_list *tgt_list);
@@ -48,10 +49,11 @@ int dfs_cache_get_tgt_referral(const char *path, const struct dfs_cache_tgt_iter
 			       struct dfs_info3_param *ref);
 int dfs_cache_get_tgt_share(char *path, const struct dfs_cache_tgt_iterator *it, char **share,
 			    char **prefix);
-char *dfs_cache_canonical_path(const char *path, const struct nls_table *cp, int remap);
 int dfs_cache_remount_fs(struct cifs_sb_info *cifs_sb);
 void dfs_cache_refresh(struct work_struct *work);
 
+extern const struct proc_ops dfscache_proc_ops;
+
 static inline struct dfs_cache_tgt_iterator *
 dfs_cache_get_next_tgt(struct dfs_cache_tgt_list *tl,
 		       struct dfs_cache_tgt_iterator *it)
diff --git a/fs/smb/client/dns_resolve.h b/fs/smb/client/dns_resolve.h
index 0dc706f2c422..69dc80533714 100644
--- a/fs/smb/client/dns_resolve.h
+++ b/fs/smb/client/dns_resolve.h
@@ -17,9 +17,6 @@
 
 #ifdef __KERNEL__
 
-int dns_resolve_name(const char *dom, const char *name,
-		     size_t namelen, struct sockaddr *ip_addr);
-
 static inline int dns_resolve_unc(const char *dom, const char *unc,
 				  struct sockaddr *ip_addr)
 {
diff --git a/fs/smb/client/fs_context.h b/fs/smb/client/fs_context.h
index b0fec6b9a23b..6e1a14e98b57 100644
--- a/fs/smb/client/fs_context.h
+++ b/fs/smb/client/fs_context.h
@@ -359,26 +359,17 @@ static inline enum cifs_symlink_type cifs_symlink_type(struct cifs_sb_info *cifs
 	return CIFS_SYMLINK_TYPE_NONE;
 }
 
-extern int smb3_init_fs_context(struct fs_context *fc);
-extern void smb3_cleanup_fs_context_contents(struct smb3_fs_context *ctx);
-extern void smb3_cleanup_fs_context(struct smb3_fs_context *ctx);
-
 static inline struct smb3_fs_context *smb3_fc2context(const struct fs_context *fc)
 {
 	return fc->fs_private;
 }
 
-extern int smb3_fs_context_dup(struct smb3_fs_context *new_ctx, struct smb3_fs_context *ctx);
-extern int smb3_sync_session_ctx_passwords(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses);
-extern void smb3_update_mnt_flags(struct cifs_sb_info *cifs_sb);
-
 /*
  * max deferred close timeout (jiffies) - 2^30
  */
 #define SMB3_MAX_DCLOSETIMEO (1 << 30)
 #define SMB3_DEF_DCLOSETIMEO (1 * HZ) /* even 1 sec enough to help eg open/write/close/open/read */
 #define MAX_CACHED_FIDS 16
-extern char *cifs_sanitize_prepath(char *prepath, gfp_t gfp);
 
 extern struct mutex cifs_mount_mutex;
 
diff --git a/fs/smb/client/fscache.h b/fs/smb/client/fscache.h
index 162865381dac..54b64f0f45da 100644
--- a/fs/smb/client/fscache.h
+++ b/fs/smb/client/fscache.h
@@ -35,13 +35,15 @@ struct cifs_fscache_inode_coherency_data {
 
 #ifdef CONFIG_CIFS_FSCACHE
 
-/* PROTOTYPES */
-extern int cifs_fscache_get_super_cookie(struct cifs_tcon *);
-extern void cifs_fscache_release_super_cookie(struct cifs_tcon *);
 
-extern void cifs_fscache_get_inode_cookie(struct inode *inode);
-extern void cifs_fscache_release_inode_cookie(struct inode *);
-extern void cifs_fscache_unuse_inode_cookie(struct inode *inode, bool update);
+/*
+ * fscache.c
+ */
+int cifs_fscache_get_super_cookie(struct cifs_tcon *tcon);
+void cifs_fscache_release_super_cookie(struct cifs_tcon *tcon);
+void cifs_fscache_get_inode_cookie(struct inode *inode);
+void cifs_fscache_unuse_inode_cookie(struct inode *inode, bool update);
+void cifs_fscache_release_inode_cookie(struct inode *inode);
 
 static inline
 void cifs_fscache_fill_coherency(struct inode *inode,
@@ -57,7 +59,6 @@ void cifs_fscache_fill_coherency(struct inode *inode,
 	cd->last_change_time_nsec = cpu_to_le32(ctime.tv_nsec);
 }
 
-
 static inline struct fscache_cookie *cifs_inode_cookie(struct inode *inode)
 {
 	return netfs_i_cookie(&CIFS_I(inode)->netfs);
diff --git a/fs/smb/client/netlink.h b/fs/smb/client/netlink.h
index 9d73b23858b8..74ef50c9a8c6 100644
--- a/fs/smb/client/netlink.h
+++ b/fs/smb/client/netlink.h
@@ -10,8 +10,11 @@
 
 extern struct genl_family cifs_genl_family;
 
-/* PROTOTYPES */
-extern int cifs_genl_init(void);
-extern void cifs_genl_exit(void);
+
+/*
+ * netlink.c
+ */
+int cifs_genl_init(void);
+void cifs_genl_exit(void);
 
 #endif /* _CIFS_NETLINK_H */
diff --git a/fs/smb/client/nterr.h b/fs/smb/client/nterr.h
index 180602c22355..104cf2c2179b 100644
--- a/fs/smb/client/nterr.h
+++ b/fs/smb/client/nterr.h
@@ -10,8 +10,6 @@
 
 */
 
-
-
 #ifndef _NTERR_H
 #define _NTERR_H
 
diff --git a/fs/smb/client/ntlmssp.h b/fs/smb/client/ntlmssp.h
index a11fddc321f6..f3571970744a 100644
--- a/fs/smb/client/ntlmssp.h
+++ b/fs/smb/client/ntlmssp.h
@@ -142,16 +142,3 @@ typedef struct _AUTHENTICATE_MESSAGE {
  * Size of the session key (crypto key encrypted with the password
  */
 
-int decode_ntlmssp_challenge(char *bcc_ptr, int blob_len, struct cifs_ses *ses);
-int build_ntlmssp_negotiate_blob(unsigned char **pbuffer, u16 *buflen,
-				 struct cifs_ses *ses,
-				 struct TCP_Server_Info *server,
-				 const struct nls_table *nls_cp);
-int build_ntlmssp_smb3_negotiate_blob(unsigned char **pbuffer, u16 *buflen,
-				 struct cifs_ses *ses,
-				 struct TCP_Server_Info *server,
-				 const struct nls_table *nls_cp);
-int build_ntlmssp_auth_blob(unsigned char **pbuffer, u16 *buflen,
-			struct cifs_ses *ses,
-			struct TCP_Server_Info *server,
-			const struct nls_table *nls_cp);
diff --git a/fs/smb/client/reparse.h b/fs/smb/client/reparse.h
index 19caab2fd11e..f288fd8e5402 100644
--- a/fs/smb/client/reparse.h
+++ b/fs/smb/client/reparse.h
@@ -126,15 +126,4 @@ static inline bool cifs_open_data_reparse(struct cifs_open_info_data *data)
 	return ret;
 }
 
-bool cifs_reparse_point_to_fattr(struct cifs_sb_info *cifs_sb,
-				 struct cifs_fattr *fattr,
-				 struct cifs_open_info_data *data);
-int create_reparse_symlink(const unsigned int xid, struct inode *inode,
-				struct dentry *dentry, struct cifs_tcon *tcon,
-				const char *full_path, const char *symname);
-int mknod_reparse(unsigned int xid, struct inode *inode,
-		       struct dentry *dentry, struct cifs_tcon *tcon,
-		       const char *full_path, umode_t mode, dev_t dev);
-struct reparse_data_buffer *smb2_get_reparse_point_buffer(const struct kvec *rsp_iov, u32 *len);
-
 #endif /* _CIFS_REPARSE_H */
diff --git a/fs/smb/client/smb1proto.h b/fs/smb/client/smb1proto.h
index 68ab0447b671..496be436dcea 100644
--- a/fs/smb/client/smb1proto.h
+++ b/fs/smb/client/smb1proto.h
@@ -15,6 +15,216 @@
 #include "dfs_cache.h"
 #endif
 
-/* PROTOTYPES */
+
+/*
+ * cifssmb.c
+ */
+int small_smb_init_no_tc(const int smb_command, const int wct,
+			 struct cifs_ses *ses, void **request_buf);
+int CIFSSMBNegotiate(const unsigned int xid,
+		     struct cifs_ses *ses,
+		     struct TCP_Server_Info *server);
+int CIFSSMBTDis(const unsigned int xid, struct cifs_tcon *tcon);
+int CIFSSMBEcho(struct TCP_Server_Info *server);
+int CIFSSMBLogoff(const unsigned int xid, struct cifs_ses *ses);
+int CIFSPOSIXDelFile(const unsigned int xid, struct cifs_tcon *tcon,
+		     const char *fileName, __u16 type,
+		     const struct nls_table *nls_codepage, int remap);
+int CIFSSMBDelFile(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
+		   struct cifs_sb_info *cifs_sb, struct dentry *dentry);
+int CIFSSMBRmDir(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
+		 struct cifs_sb_info *cifs_sb);
+int CIFSSMBMkDir(const unsigned int xid, struct inode *inode, umode_t mode,
+		 struct cifs_tcon *tcon, const char *name,
+		 struct cifs_sb_info *cifs_sb);
+int CIFSPOSIXCreate(const unsigned int xid, struct cifs_tcon *tcon,
+		    __u32 posix_flags, __u64 mode, __u16 *netfid,
+		    FILE_UNIX_BASIC_INFO *pRetData, __u32 *pOplock,
+		    const char *name, const struct nls_table *nls_codepage,
+		    int remap);
+int SMBLegacyOpen(const unsigned int xid, struct cifs_tcon *tcon,
+		  const char *fileName, const int openDisposition,
+		  const int access_flags, const int create_options, __u16 *netfid,
+		  int *pOplock, FILE_ALL_INFO *pfile_info,
+		  const struct nls_table *nls_codepage, int remap);
+int CIFS_open(const unsigned int xid, struct cifs_open_parms *oparms, int *oplock,
+	      FILE_ALL_INFO *buf);
+int cifs_async_readv(struct cifs_io_subrequest *rdata);
+int CIFSSMBRead(const unsigned int xid, struct cifs_io_parms *io_parms,
+		unsigned int *nbytes, char **buf, int *pbuf_type);
+int CIFSSMBWrite(const unsigned int xid, struct cifs_io_parms *io_parms,
+		 unsigned int *nbytes, const char *buf);
+void cifs_async_writev(struct cifs_io_subrequest *wdata);
+int CIFSSMBWrite2(const unsigned int xid, struct cifs_io_parms *io_parms,
+		  unsigned int *nbytes, struct kvec *iov, int n_vec);
+int cifs_lockv(const unsigned int xid, struct cifs_tcon *tcon,
+	       const __u16 netfid, const __u8 lock_type, const __u32 num_unlock,
+	       const __u32 num_lock, LOCKING_ANDX_RANGE *buf);
+int CIFSSMBLock(const unsigned int xid, struct cifs_tcon *tcon,
+		const __u16 smb_file_id, const __u32 netpid, const __u64 len,
+		const __u64 offset, const __u32 numUnlock,
+		const __u32 numLock, const __u8 lockType,
+		const bool waitFlag, const __u8 oplock_level);
+int CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
+		     const __u16 smb_file_id, const __u32 netpid,
+		     const loff_t start_offset, const __u64 len,
+		     struct file_lock *pLockData, const __u16 lock_type,
+		     const bool waitFlag);
+int CIFSSMBClose(const unsigned int xid, struct cifs_tcon *tcon, int smb_file_id);
+int CIFSSMBFlush(const unsigned int xid, struct cifs_tcon *tcon, int smb_file_id);
+int CIFSSMBRename(const unsigned int xid, struct cifs_tcon *tcon,
+		  struct dentry *source_dentry,
+		  const char *from_name, const char *to_name,
+		  struct cifs_sb_info *cifs_sb);
+int CIFSSMBRenameOpenFile(const unsigned int xid, struct cifs_tcon *pTcon,
+			  int netfid, const char *target_name,
+			  const struct nls_table *nls_codepage, int remap);
+int CIFSUnixCreateSymLink(const unsigned int xid, struct cifs_tcon *tcon,
+			  const char *fromName, const char *toName,
+			  const struct nls_table *nls_codepage, int remap);
+int CIFSUnixCreateHardLink(const unsigned int xid, struct cifs_tcon *tcon,
+			   const char *fromName, const char *toName,
+			   const struct nls_table *nls_codepage, int remap);
+int CIFSCreateHardLink(const unsigned int xid,
+		       struct cifs_tcon *tcon,
+		       struct dentry *source_dentry,
+		       const char *from_name, const char *to_name,
+		       struct cifs_sb_info *cifs_sb);
+int CIFSSMBUnixQuerySymLink(const unsigned int xid, struct cifs_tcon *tcon,
+			    const unsigned char *searchName, char **symlinkinfo,
+			    const struct nls_table *nls_codepage, int remap);
+int cifs_query_reparse_point(const unsigned int xid,
+			     struct cifs_tcon *tcon,
+			     struct cifs_sb_info *cifs_sb,
+			     const char *full_path,
+			     u32 *tag, struct kvec *rsp,
+			     int *rsp_buftype);
+struct inode *cifs_create_reparse_inode(struct cifs_open_info_data *data,
+					struct super_block *sb,
+					const unsigned int xid,
+					struct cifs_tcon *tcon,
+					const char *full_path,
+					bool directory,
+					struct kvec *reparse_iov,
+					struct kvec *xattr_iov);
+int CIFSSMB_set_compression(const unsigned int xid, struct cifs_tcon *tcon,
+			    __u16 fid);
+int cifs_do_get_acl(const unsigned int xid, struct cifs_tcon *tcon,
+		    const unsigned char *searchName, struct posix_acl **acl,
+		    const int acl_type, const struct nls_table *nls_codepage,
+		    int remap);
+int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
+		    const unsigned char *fileName, const struct posix_acl *acl,
+		    const int acl_type, const struct nls_table *nls_codepage,
+		    int remap);
+int cifs_do_get_acl(const unsigned int xid, struct cifs_tcon *tcon,
+		    const unsigned char *searchName, struct posix_acl **acl,
+		    const int acl_type, const struct nls_table *nls_codepage,
+		    int remap);
+int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
+		    const unsigned char *fileName, const struct posix_acl *acl,
+		    const int acl_type, const struct nls_table *nls_codepage,
+		    int remap);
+int CIFSGetExtAttr(const unsigned int xid, struct cifs_tcon *tcon,
+		   const int netfid, __u64 *pExtAttrBits, __u64 *pMask);
+int CIFSSMBGetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon, __u16 fid,
+		      struct smb_ntsd **acl_inf, __u32 *pbuflen, __u32 info);
+int CIFSSMBSetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon, __u16 fid,
+		      struct smb_ntsd *pntsd, __u32 acllen, int aclflag);
+int SMBQueryInformation(const unsigned int xid, struct cifs_tcon *tcon,
+			const char *search_name, FILE_ALL_INFO *data,
+			const struct nls_table *nls_codepage, int remap);
+int CIFSSMBQFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
+		     u16 netfid, FILE_ALL_INFO *pFindData);
+int CIFSSMBQPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
+		     const char *search_name, FILE_ALL_INFO *data,
+		     int legacy /* old style infolevel */,
+		     const struct nls_table *nls_codepage, int remap);
+int CIFSSMBUnixQFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
+			 u16 netfid, FILE_UNIX_BASIC_INFO *pFindData);
+int CIFSSMBUnixQPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
+			 const unsigned char *searchName,
+			 FILE_UNIX_BASIC_INFO *pFindData,
+			 const struct nls_table *nls_codepage, int remap);
+int CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
+		  const char *searchName, struct cifs_sb_info *cifs_sb,
+		  __u16 *pnetfid, __u16 search_flags,
+		  struct cifs_search_info *psrch_inf, bool msearch);
+int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
+		 __u16 searchHandle, __u16 search_flags,
+		 struct cifs_search_info *psrch_inf);
+int CIFSFindClose(const unsigned int xid, struct cifs_tcon *tcon,
+		  const __u16 searchHandle);
+int CIFSGetSrvInodeNumber(const unsigned int xid, struct cifs_tcon *tcon,
+			  const char *search_name, __u64 *inode_number,
+			  const struct nls_table *nls_codepage, int remap);
+int CIFSGetDFSRefer(const unsigned int xid, struct cifs_ses *ses,
+		    const char *search_name, struct dfs_info3_param **target_nodes,
+		    unsigned int *num_of_nodes,
+		    const struct nls_table *nls_codepage, int remap);
+int SMBOldQFSInfo(const unsigned int xid, struct cifs_tcon *tcon,
+		  struct kstatfs *FSData);
+int CIFSSMBQFSInfo(const unsigned int xid, struct cifs_tcon *tcon,
+		   struct kstatfs *FSData);
+int CIFSSMBQFSAttributeInfo(const unsigned int xid, struct cifs_tcon *tcon);
+int CIFSSMBQFSDeviceInfo(const unsigned int xid, struct cifs_tcon *tcon);
+int CIFSSMBQFSUnixInfo(const unsigned int xid, struct cifs_tcon *tcon);
+int CIFSSMBSetFSUnixInfo(const unsigned int xid, struct cifs_tcon *tcon, __u64 cap);
+int CIFSSMBQFSPosixInfo(const unsigned int xid, struct cifs_tcon *tcon,
+			struct kstatfs *FSData);
+int CIFSSMBSetEOF(const unsigned int xid, struct cifs_tcon *tcon,
+		  const char *file_name, __u64 size, struct cifs_sb_info *cifs_sb,
+		  bool set_allocation, struct dentry *dentry);
+int CIFSSMBSetFileSize(const unsigned int xid, struct cifs_tcon *tcon,
+		       struct cifsFileInfo *cfile, __u64 size, bool set_allocation);
+int SMBSetInformation(const unsigned int xid, struct cifs_tcon *tcon,
+		      const char *fileName, __le32 attributes, __le64 write_time,
+		      const struct nls_table *nls_codepage,
+		      struct cifs_sb_info *cifs_sb);
+int CIFSSMBSetFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
+		       const FILE_BASIC_INFO *data, __u16 fid, __u32 pid_of_opener);
+int CIFSSMBSetFileDisposition(const unsigned int xid, struct cifs_tcon *tcon,
+			      bool delete_file, __u16 fid, __u32 pid_of_opener);
+int CIFSSMBSetPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
+		       const char *fileName, const FILE_BASIC_INFO *data,
+		       const struct nls_table *nls_codepage,
+		       struct cifs_sb_info *cifs_sb);
+int CIFSSMBUnixSetFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
+			   const struct cifs_unix_set_info_args *args,
+			   u16 fid, u32 pid_of_opener);
+int CIFSSMBUnixSetPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
+			   const char *file_name,
+			   const struct cifs_unix_set_info_args *args,
+			   const struct nls_table *nls_codepage, int remap);
+ssize_t CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
+		       const unsigned char *searchName, const unsigned char *ea_name,
+		       char *EAData, size_t buf_size,
+		       struct cifs_sb_info *cifs_sb);
+int CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
+		 const char *fileName, const char *ea_name, const void *ea_value,
+		 const __u16 ea_value_len, const struct nls_table *nls_codepage,
+		 struct cifs_sb_info *cifs_sb);
+
+/*
+ * cifstransport.c
+ */
+int smb_send(struct TCP_Server_Info *server, struct smb_hdr *smb_buffer,
+	     unsigned int smb_buf_length);
+struct mid_q_entry *cifs_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst *rqst);
+int SendReceiveNoRsp(const unsigned int xid, struct cifs_ses *ses,
+		     char *in_buf, int flags);
+int cifs_check_receive(struct mid_q_entry *mid, struct TCP_Server_Info *server,
+		       bool log_error);
+struct mid_q_entry *cifs_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *ignored,
+				       struct smb_rqst *rqst);
+int SendReceive2(const unsigned int xid, struct cifs_ses *ses,
+		 struct kvec *iov, int n_vec, int *resp_buf_type /* ret */,
+		 const int flags, struct kvec *resp_iov);
+int SendReceive(const unsigned int xid, struct cifs_ses *ses,
+		struct smb_hdr *in_buf, struct smb_hdr *out_buf,
+		int *pbytes_returned, const int flags);
+int SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
+			    struct smb_hdr *in_buf, struct smb_hdr *out_buf,
+			    int *pbytes_returned);
 
 #endif /* _SMB1PROTO_H */
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index dca9bc875f8d..01cde09d98ac 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -17,76 +17,37 @@
 struct statfs;
 struct smb_rqst;
 
-/* PROTOTYPES */
 
-extern int map_smb2_to_linux_error(char *buf, bool log_err);
-extern int smb2_check_message(char *buf, unsigned int length,
-			      struct TCP_Server_Info *server);
-extern unsigned int smb2_calc_size(void *buf);
-extern char *smb2_get_data_area_len(int *off, int *len,
-				    struct smb2_hdr *shdr);
-extern __le16 *cifs_convert_path_to_utf16(const char *from,
-					  struct cifs_sb_info *cifs_sb);
+/*
+ * smb2file.c
+ */
+int smb2_fix_symlink_target_type(char **target, bool directory, struct cifs_sb_info *cifs_sb);
+int smb2_parse_symlink_response(struct cifs_sb_info *cifs_sb, const struct kvec *iov,
+				const char *full_path, char **path);
+int smb2_open_file(const unsigned int xid, struct cifs_open_parms *oparms,
+		   __u32 *oplock, void *buf);
+int smb2_unlock_range(struct cifsFileInfo *cfile, struct file_lock *flock,
+		      const unsigned int xid);
+int smb2_push_mandatory_locks(struct cifsFileInfo *cfile);
 
-extern int smb2_verify_signature(struct smb_rqst *, struct TCP_Server_Info *);
-extern int smb2_check_receive(struct mid_q_entry *mid,
-			      struct TCP_Server_Info *server, bool log_error);
-extern struct mid_q_entry *smb2_setup_request(struct cifs_ses *ses,
-					      struct TCP_Server_Info *,
-					      struct smb_rqst *rqst);
-extern struct mid_q_entry *smb2_setup_async_request(
-			struct TCP_Server_Info *server, struct smb_rqst *rqst);
-extern struct cifs_tcon *smb2_find_smb_tcon(struct TCP_Server_Info *server,
-						__u64 ses_id, __u32  tid);
-extern void smb2_echo_request(struct work_struct *work);
-extern __le32 smb2_get_lease_state(struct cifsInodeInfo *cinode);
-extern bool smb2_is_valid_oplock_break(char *buffer,
-				       struct TCP_Server_Info *srv);
-extern int smb3_handle_read_data(struct TCP_Server_Info *server,
-				 struct mid_q_entry *mid);
-extern int smb2_query_reparse_tag(const unsigned int xid, struct cifs_tcon *tcon,
-				struct cifs_sb_info *cifs_sb, const char *path,
-				__u32 *reparse_tag);
-struct inode *smb2_create_reparse_inode(struct cifs_open_info_data *data,
-				     struct super_block *sb,
-				     const unsigned int xid,
-				     struct cifs_tcon *tcon,
-				     const char *full_path,
-				     bool directory,
-				     struct kvec *reparse_iov,
-				     struct kvec *xattr_iov);
-int smb2_query_reparse_point(const unsigned int xid,
-			     struct cifs_tcon *tcon,
-			     struct cifs_sb_info *cifs_sb,
-			     const char *full_path,
-			     u32 *tag, struct kvec *rsp,
-			     int *rsp_buftype);
+/*
+ * smb2inode.c
+ */
 int smb2_query_path_info(const unsigned int xid,
 			 struct cifs_tcon *tcon,
 			 struct cifs_sb_info *cifs_sb,
 			 const char *full_path,
 			 struct cifs_open_info_data *data);
-extern int smb2_set_path_size(const unsigned int xid, struct cifs_tcon *tcon,
-			      const char *full_path, __u64 size,
-			      struct cifs_sb_info *cifs_sb, bool set_alloc,
-				  struct dentry *dentry);
-extern int smb2_set_file_info(struct inode *inode, const char *full_path,
-			      FILE_BASIC_INFO *buf, const unsigned int xid);
-extern int smb311_posix_mkdir(const unsigned int xid, struct inode *inode,
-			       umode_t mode, struct cifs_tcon *tcon,
-			       const char *full_path,
-			       struct cifs_sb_info *cifs_sb);
-extern int smb2_mkdir(const unsigned int xid, struct inode *inode,
-		      umode_t mode, struct cifs_tcon *tcon,
-		      const char *name, struct cifs_sb_info *cifs_sb);
-extern void smb2_mkdir_setinfo(struct inode *inode, const char *full_path,
-			       struct cifs_sb_info *cifs_sb,
-			       struct cifs_tcon *tcon, const unsigned int xid);
-extern int smb2_rmdir(const unsigned int xid, struct cifs_tcon *tcon,
-		      const char *name, struct cifs_sb_info *cifs_sb);
-extern int smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon,
-		       const char *name, struct cifs_sb_info *cifs_sb,
-			   struct dentry *dentry);
+int smb2_mkdir(const unsigned int xid, struct inode *parent_inode, umode_t mode,
+	       struct cifs_tcon *tcon, const char *name,
+	       struct cifs_sb_info *cifs_sb);
+void smb2_mkdir_setinfo(struct inode *inode, const char *name,
+			struct cifs_sb_info *cifs_sb, struct cifs_tcon *tcon,
+			const unsigned int xid);
+int smb2_rmdir(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
+	       struct cifs_sb_info *cifs_sb);
+int smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
+		struct cifs_sb_info *cifs_sb, struct dentry *dentry);
 int smb2_rename_path(const unsigned int xid,
 		     struct cifs_tcon *tcon,
 		     struct dentry *source_dentry,
@@ -97,221 +58,242 @@ int smb2_create_hardlink(const unsigned int xid,
 			 struct dentry *source_dentry,
 			 const char *from_name, const char *to_name,
 			 struct cifs_sb_info *cifs_sb);
-extern int smb3_create_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
-			struct cifs_sb_info *cifs_sb, const unsigned char *path,
-			char *pbuf, unsigned int *pbytes_written);
-extern int smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
-			  struct cifs_sb_info *cifs_sb,
-			  const unsigned char *path, char *pbuf,
-			  unsigned int *pbytes_read);
-int smb2_fix_symlink_target_type(char **target, bool directory, struct cifs_sb_info *cifs_sb);
-int smb2_parse_native_symlink(char **target, const char *buf, unsigned int len,
-			      bool relative,
-			      const char *full_path,
-			      struct cifs_sb_info *cifs_sb);
-int smb2_parse_symlink_response(struct cifs_sb_info *cifs_sb,
-				const struct kvec *iov,
-				const char *full_path,
-				char **path);
-int smb2_open_file(const unsigned int xid, struct cifs_open_parms *oparms, __u32 *oplock,
-		   void *buf);
-extern int smb2_unlock_range(struct cifsFileInfo *cfile,
-			     struct file_lock *flock, const unsigned int xid);
-extern int smb2_push_mandatory_locks(struct cifsFileInfo *cfile);
-extern void smb2_reconnect_server(struct work_struct *work);
-extern int smb3_crypto_aead_allocate(struct TCP_Server_Info *server);
-extern unsigned long smb_rqst_len(struct TCP_Server_Info *server,
-				  struct smb_rqst *rqst);
-extern void smb2_set_next_command(struct cifs_tcon *tcon,
-				  struct smb_rqst *rqst);
-extern void smb2_set_related(struct smb_rqst *rqst);
-extern void smb2_set_replay(struct TCP_Server_Info *server,
-			    struct smb_rqst *rqst);
-extern bool smb2_should_replay(struct cifs_tcon *tcon,
-			  int *pretries,
-			  int *pcur_sleep);
+int smb2_set_path_size(const unsigned int xid, struct cifs_tcon *tcon,
+		       const char *full_path, __u64 size,
+		       struct cifs_sb_info *cifs_sb, bool set_alloc,
+		       struct dentry *dentry);
+int smb2_set_file_info(struct inode *inode, const char *full_path,
+		       FILE_BASIC_INFO *buf, const unsigned int xid);
+struct inode *smb2_create_reparse_inode(struct cifs_open_info_data *data,
+					struct super_block *sb,
+					const unsigned int xid,
+					struct cifs_tcon *tcon,
+					const char *full_path,
+					bool directory,
+					struct kvec *reparse_iov,
+					struct kvec *xattr_iov);
+int smb2_query_reparse_point(const unsigned int xid,
+			     struct cifs_tcon *tcon,
+			     struct cifs_sb_info *cifs_sb,
+			     const char *full_path,
+			     u32 *tag, struct kvec *rsp,
+			     int *rsp_buftype);
+int smb2_rename_pending_delete(const char *full_path,
+			       struct dentry *dentry,
+			       const unsigned int xid);
 
 /*
- * SMB2 Worker functions - most of protocol specific implementation details
- * are contained within these calls.
+ * smb2maperror.c
  */
-extern int SMB2_negotiate(const unsigned int xid,
-			  struct cifs_ses *ses,
-			  struct TCP_Server_Info *server);
-extern int SMB2_sess_setup(const unsigned int xid, struct cifs_ses *ses,
-			   struct TCP_Server_Info *server,
-			   const struct nls_table *nls_cp);
-extern int SMB2_logoff(const unsigned int xid, struct cifs_ses *ses);
-extern int SMB2_tcon(const unsigned int xid, struct cifs_ses *ses,
-		     const char *tree, struct cifs_tcon *tcon,
-		     const struct nls_table *);
-extern int SMB2_tdis(const unsigned int xid, struct cifs_tcon *tcon);
-extern int SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms,
-		     __le16 *path, __u8 *oplock,
-		     struct smb2_file_all_info *buf,
-		     struct create_posix_rsp *posix,
-		     struct kvec *err_iov, int *resp_buftype);
-extern int SMB2_open_init(struct cifs_tcon *tcon,
-			  struct TCP_Server_Info *server,
-			  struct smb_rqst *rqst,
-			  __u8 *oplock, struct cifs_open_parms *oparms,
-			  __le16 *path);
-extern void SMB2_open_free(struct smb_rqst *rqst);
-extern int SMB2_ioctl(const unsigned int xid, struct cifs_tcon *tcon,
-		     u64 persistent_fid, u64 volatile_fid, u32 opcode,
-		     char *in_data, u32 indatalen, u32 maxoutlen,
-		     char **out_data, u32 *plen /* returned data len */);
-extern int SMB2_ioctl_init(struct cifs_tcon *tcon,
-			   struct TCP_Server_Info *server,
-			   struct smb_rqst *rqst,
-			   u64 persistent_fid, u64 volatile_fid, u32 opcode,
-			   char *in_data, u32 indatalen,
-			   __u32 max_response_size);
-extern void SMB2_ioctl_free(struct smb_rqst *rqst);
-extern int SMB2_change_notify(const unsigned int xid, struct cifs_tcon *tcon,
-			u64 persistent_fid, u64 volatile_fid, bool watch_tree,
-			u32 completion_filter, u32 max_out_data_len,
-			char **out_data, u32 *plen /* returned data len */);
+int map_smb2_to_linux_error(char *buf, bool log_err);
 
-extern int __SMB2_close(const unsigned int xid, struct cifs_tcon *tcon,
-			u64 persistent_fid, u64 volatile_fid,
-			struct smb2_file_network_open_info *pbuf);
-extern int SMB2_close(const unsigned int xid, struct cifs_tcon *tcon,
-		      u64 persistent_file_id, u64 volatile_file_id);
-extern int SMB2_close_init(struct cifs_tcon *tcon,
-			   struct TCP_Server_Info *server,
-			   struct smb_rqst *rqst,
-			   u64 persistent_fid, u64 volatile_fid,
-			   bool query_attrs);
-extern void SMB2_close_free(struct smb_rqst *rqst);
-extern int SMB2_flush(const unsigned int xid, struct cifs_tcon *tcon,
-		      u64 persistent_file_id, u64 volatile_file_id);
-extern int SMB2_flush_init(const unsigned int xid, struct smb_rqst *rqst,
-			   struct cifs_tcon *tcon,
-			   struct TCP_Server_Info *server,
-			   u64 persistent_file_id, u64 volatile_file_id);
-extern void SMB2_flush_free(struct smb_rqst *rqst);
-extern int SMB311_posix_query_info(const unsigned int xid, struct cifs_tcon *tcon,
-		u64 persistent_fid, u64 volatile_fid, struct smb311_posix_qinfo *data, u32 *plen);
-extern int SMB2_query_info(const unsigned int xid, struct cifs_tcon *tcon,
-			   u64 persistent_file_id, u64 volatile_file_id,
-			   struct smb2_file_all_info *data);
-extern int SMB2_query_info_init(struct cifs_tcon *tcon,
-				struct TCP_Server_Info *server,
-				struct smb_rqst *rqst,
-				u64 persistent_fid, u64 volatile_fid,
-				u8 info_class, u8 info_type,
-				u32 additional_info, size_t output_len,
-				size_t input_len, void *input);
-extern void SMB2_query_info_free(struct smb_rqst *rqst);
-extern int SMB2_query_acl(const unsigned int xid, struct cifs_tcon *tcon,
-			  u64 persistent_file_id, u64 volatile_file_id,
-			  void **data, unsigned int *plen, u32 info);
-extern int SMB2_get_srv_num(const unsigned int xid, struct cifs_tcon *tcon,
-			    u64 persistent_fid, u64 volatile_fid,
-			    __le64 *uniqueid);
-extern int smb2_async_readv(struct cifs_io_subrequest *rdata);
-extern int SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
-		     unsigned int *nbytes, char **buf, int *buf_type);
-extern void smb2_async_writev(struct cifs_io_subrequest *wdata);
-extern int SMB2_write(const unsigned int xid, struct cifs_io_parms *io_parms,
-		      unsigned int *nbytes, struct kvec *iov, int n_vec);
-extern int SMB2_echo(struct TCP_Server_Info *server);
-extern int SMB2_query_directory(const unsigned int xid, struct cifs_tcon *tcon,
-				u64 persistent_fid, u64 volatile_fid, int index,
-				struct cifs_search_info *srch_inf);
-extern int SMB2_query_directory_init(unsigned int xid, struct cifs_tcon *tcon,
-				     struct TCP_Server_Info *server,
-				     struct smb_rqst *rqst,
-				     u64 persistent_fid, u64 volatile_fid,
-				     int index, int info_level);
-extern void SMB2_query_directory_free(struct smb_rqst *rqst);
-extern int SMB2_set_eof(const unsigned int xid, struct cifs_tcon *tcon,
-			u64 persistent_fid, u64 volatile_fid, u32 pid,
-			loff_t new_eof);
-extern int SMB2_set_info_init(struct cifs_tcon *tcon,
-			      struct TCP_Server_Info *server,
-			      struct smb_rqst *rqst,
-			      u64 persistent_fid, u64 volatile_fid, u32 pid,
-			      u8 info_class, u8 info_type, u32 additional_info,
-			      void **data, unsigned int *size);
-extern void SMB2_set_info_free(struct smb_rqst *rqst);
-extern int SMB2_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
-			u64 persistent_fid, u64 volatile_fid,
-			struct smb_ntsd *pnntsd, int pacllen, int aclflag);
-extern int SMB2_set_ea(const unsigned int xid, struct cifs_tcon *tcon,
-		       u64 persistent_fid, u64 volatile_fid,
-		       struct smb2_file_full_ea_info *buf, int len);
-extern int SMB2_set_compression(const unsigned int xid, struct cifs_tcon *tcon,
-				u64 persistent_fid, u64 volatile_fid);
-extern int SMB2_oplock_break(const unsigned int xid, struct cifs_tcon *tcon,
-			     const u64 persistent_fid, const u64 volatile_fid,
-			     const __u8 oplock_level);
-extern int smb2_handle_cancelled_close(struct cifs_tcon *tcon,
-				       __u64 persistent_fid,
-				       __u64 volatile_fid);
-extern int smb2_handle_cancelled_mid(struct mid_q_entry *mid, struct TCP_Server_Info *server);
+/*
+ * smb2misc.c
+ */
+int smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *server);
+char *smb2_get_data_area_len(int *off, int *len, struct smb2_hdr *shdr);
+unsigned int smb2_calc_size(void *buf);
+__le16 *cifs_convert_path_to_utf16(const char *from, struct cifs_sb_info *cifs_sb);
+__le32 smb2_get_lease_state(struct cifsInodeInfo *cinode);
+bool smb2_is_valid_oplock_break(char *buffer, struct TCP_Server_Info *server);
 void smb2_cancelled_close_fid(struct work_struct *work);
-extern int SMB311_posix_qfs_info(const unsigned int xid, struct cifs_tcon *tcon,
-			 u64 persistent_file_id, u64 volatile_file_id,
-			 struct kstatfs *FSData);
-extern int SMB2_QFS_attr(const unsigned int xid, struct cifs_tcon *tcon,
-			 u64 persistent_file_id, u64 volatile_file_id, int lvl);
-extern int SMB2_lock(const unsigned int xid, struct cifs_tcon *tcon,
-		     const __u64 persist_fid, const __u64 volatile_fid,
-		     const __u32 pid, const __u64 length, const __u64 offset,
-		     const __u32 lockFlags, const bool wait);
-extern int smb2_lockv(const unsigned int xid, struct cifs_tcon *tcon,
-		      const __u64 persist_fid, const __u64 volatile_fid,
-		      const __u32 pid, const __u32 num_lock,
-		      struct smb2_lock_element *buf);
-extern int SMB2_lease_break(const unsigned int xid, struct cifs_tcon *tcon,
-			    __u8 *lease_key, const __le32 lease_state);
-extern int smb3_validate_negotiate(const unsigned int, struct cifs_tcon *);
+int smb2_handle_cancelled_close(struct cifs_tcon *tcon, __u64 persistent_fid,
+				__u64 volatile_fid);
+int smb2_handle_cancelled_mid(struct mid_q_entry *mid, struct TCP_Server_Info *server);
+void smb311_update_preauth_hash(struct cifs_ses *ses, struct TCP_Server_Info *server,
+				struct kvec *iov, int nvec);
 
-extern enum securityEnum smb2_select_sectype(struct TCP_Server_Info *,
-					enum securityEnum);
+/*
+ * smb2ops.c
+ */
+int SMB3_request_interfaces(const unsigned int xid, struct cifs_tcon *tcon, bool in_mount);
+void smb2_set_replay(struct TCP_Server_Info *server, struct smb_rqst *rqst);
+void smb2_set_related(struct smb_rqst *rqst);
+void smb2_set_next_command(struct cifs_tcon *tcon, struct smb_rqst *rqst);
+bool smb2_should_replay(struct cifs_tcon *tcon,
+			int *pretries,
+			int *pcur_sleep);
+int smb2_query_info_compound(const unsigned int xid, struct cifs_tcon *tcon,
+			     const char *path, u32 desired_access,
+			     u32 class, u32 type, u32 output_len,
+			     struct kvec *rsp, int *buftype,
+			     struct cifs_sb_info *cifs_sb);
+void smb3_free_compound_rqst(int num_rqst, struct smb_rqst *rqst);
+int smb3_handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid);
+int __cifs_sfu_make_node(unsigned int xid, struct inode *inode,
+			 struct dentry *dentry, struct cifs_tcon *tcon,
+			 const char *full_path, umode_t mode, dev_t dev,
+			 const char *symname);
+int cifs_sfu_make_node(unsigned int xid, struct inode *inode,
+		       struct dentry *dentry, struct cifs_tcon *tcon,
+		       const char *full_path, umode_t mode, dev_t dev);
+
+/*
+ * smb2pdu.c
+ */
+int smb3_encryption_required(const struct cifs_tcon *tcon);
+int SMB2_negotiate(const unsigned int xid,
+		   struct cifs_ses *ses,
+		   struct TCP_Server_Info *server);
+int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon);
+enum securityEnum smb2_select_sectype(struct TCP_Server_Info *server, enum securityEnum requested);
+int SMB2_sess_setup(const unsigned int xid, struct cifs_ses *ses,
+		    struct TCP_Server_Info *server,
+		    const struct nls_table *nls_cp);
+int SMB2_logoff(const unsigned int xid, struct cifs_ses *ses);
+int SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
+	      struct cifs_tcon *tcon, const struct nls_table *cp);
+int SMB2_tdis(const unsigned int xid, struct cifs_tcon *tcon);
 int smb2_parse_contexts(struct TCP_Server_Info *server,
 			struct kvec *rsp_iov,
 			__u16 *epoch,
 			char *lease_key, __u8 *oplock,
 			struct smb2_file_all_info *buf,
 			struct create_posix_rsp *posix);
-
-extern int smb3_encryption_required(const struct cifs_tcon *tcon);
-extern int smb2_validate_iov(unsigned int offset, unsigned int buffer_length,
-			     struct kvec *iov, unsigned int min_buf_size);
-extern int smb2_validate_and_copy_iov(unsigned int offset,
-				      unsigned int buffer_length,
-				      struct kvec *iov,
-				      unsigned int minbufsize, char *data);
-extern void smb2_copy_fs_info_to_kstatfs(
-	 struct smb2_fs_full_size_info *pfs_inf,
-	 struct kstatfs *kst);
-extern int smb3_crypto_shash_allocate(struct TCP_Server_Info *server);
-extern void smb311_update_preauth_hash(struct cifs_ses *ses,
-				       struct TCP_Server_Info *server,
-				       struct kvec *iov, int nvec);
-extern int smb2_query_info_compound(const unsigned int xid,
-				    struct cifs_tcon *tcon,
-				    const char *path, u32 desired_access,
-				    u32 class, u32 type, u32 output_len,
-				    struct kvec *rsp, int *buftype,
-				    struct cifs_sb_info *cifs_sb);
-/* query path info from the server using SMB311 POSIX extensions*/
-int smb311_posix_query_path_info(const unsigned int xid,
-				 struct cifs_tcon *tcon,
-				 struct cifs_sb_info *cifs_sb,
-				 const char *full_path,
-				 struct cifs_open_info_data *data);
+int smb311_posix_mkdir(const unsigned int xid, struct inode *inode,
+		       umode_t mode, struct cifs_tcon *tcon,
+		       const char *full_path,
+		       struct cifs_sb_info *cifs_sb);
+int SMB2_open_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
+		   struct smb_rqst *rqst, __u8 *oplock,
+		   struct cifs_open_parms *oparms, __le16 *path);
+void SMB2_open_free(struct smb_rqst *rqst);
+int SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
+	      __u8 *oplock, struct smb2_file_all_info *buf,
+	      struct create_posix_rsp *posix,
+	      struct kvec *err_iov, int *buftype);
+int SMB2_ioctl_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
+		    struct smb_rqst *rqst,
+		    u64 persistent_fid, u64 volatile_fid, u32 opcode,
+		    char *in_data, u32 indatalen,
+		    __u32 max_response_size);
+void SMB2_ioctl_free(struct smb_rqst *rqst);
+int SMB2_ioctl(const unsigned int xid, struct cifs_tcon *tcon, u64 persistent_fid,
+	       u64 volatile_fid, u32 opcode, char *in_data, u32 indatalen,
+	       u32 max_out_data_len, char **out_data,
+	       u32 *plen /* returned data len */);
+int SMB2_set_compression(const unsigned int xid, struct cifs_tcon *tcon,
+			 u64 persistent_fid, u64 volatile_fid);
+int SMB2_close_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
+		    struct smb_rqst *rqst,
+		    u64 persistent_fid, u64 volatile_fid, bool query_attrs);
+void SMB2_close_free(struct smb_rqst *rqst);
+int __SMB2_close(const unsigned int xid, struct cifs_tcon *tcon,
+		 u64 persistent_fid, u64 volatile_fid,
+		 struct smb2_file_network_open_info *pbuf);
+int SMB2_close(const unsigned int xid, struct cifs_tcon *tcon,
+	       u64 persistent_fid, u64 volatile_fid);
+int smb2_validate_iov(unsigned int offset, unsigned int buffer_length,
+		      struct kvec *iov, unsigned int min_buf_size);
+int smb2_validate_and_copy_iov(unsigned int offset, unsigned int buffer_length,
+			       struct kvec *iov, unsigned int minbufsize,
+			       char *data);
+int SMB2_query_info_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
+			 struct smb_rqst *rqst,
+			 u64 persistent_fid, u64 volatile_fid,
+			 u8 info_class, u8 info_type, u32 additional_info,
+			 size_t output_len, size_t input_len, void *input);
+void SMB2_query_info_free(struct smb_rqst *rqst);
+int SMB2_query_info(const unsigned int xid, struct cifs_tcon *tcon,
+		    u64 persistent_fid, u64 volatile_fid, struct smb2_file_all_info *data);
+int SMB311_posix_query_info(const unsigned int xid, struct cifs_tcon *tcon,
+			    u64 persistent_fid, u64 volatile_fid,
+			    struct smb311_posix_qinfo *data, u32 *plen);
+int SMB2_query_acl(const unsigned int xid, struct cifs_tcon *tcon,
+		   u64 persistent_fid, u64 volatile_fid,
+		   void **data, u32 *plen, u32 extra_info);
+int SMB2_get_srv_num(const unsigned int xid, struct cifs_tcon *tcon,
+		     u64 persistent_fid, u64 volatile_fid, __le64 *uniqueid);
+int SMB2_change_notify(const unsigned int xid, struct cifs_tcon *tcon,
+		       u64 persistent_fid, u64 volatile_fid, bool watch_tree,
+		       u32 completion_filter, u32 max_out_data_len, char **out_data,
+		       u32 *plen /* returned data len */);
+void smb2_reconnect_server(struct work_struct *work);
+int SMB2_echo(struct TCP_Server_Info *server);
+void SMB2_flush_free(struct smb_rqst *rqst);
+int SMB2_flush_init(const unsigned int xid, struct smb_rqst *rqst,
+		    struct cifs_tcon *tcon, struct TCP_Server_Info *server,
+		    u64 persistent_fid, u64 volatile_fid);
+int SMB2_flush(const unsigned int xid, struct cifs_tcon *tcon, u64 persistent_fid,
+	       u64 volatile_fid);
+int smb2_async_readv(struct cifs_io_subrequest *rdata);
+int SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
+	      unsigned int *nbytes, char **buf, int *buf_type);
+void smb2_async_writev(struct cifs_io_subrequest *wdata);
+int SMB2_write(const unsigned int xid, struct cifs_io_parms *io_parms,
+	       unsigned int *nbytes, struct kvec *iov, int n_vec);
+int posix_info_sid_size(const void *beg, const void *end);
 int posix_info_parse(const void *beg, const void *end,
 		     struct smb2_posix_info_parsed *out);
-int posix_info_sid_size(const void *beg, const void *end);
-int smb2_make_nfs_node(unsigned int xid, struct inode *inode,
-		       struct dentry *dentry, struct cifs_tcon *tcon,
-		       const char *full_path, umode_t mode, dev_t dev);
-int smb2_rename_pending_delete(const char *full_path,
-			       struct dentry *dentry,
-			       const unsigned int xid);
+int SMB2_query_directory_init(const unsigned int xid,
+			      struct cifs_tcon *tcon,
+			      struct TCP_Server_Info *server,
+			      struct smb_rqst *rqst,
+			      u64 persistent_fid, u64 volatile_fid,
+			      int index, int info_level);
+void SMB2_query_directory_free(struct smb_rqst *rqst);
+int smb2_parse_query_directory(struct cifs_tcon *tcon,
+			       struct kvec *rsp_iov,
+			       int resp_buftype,
+			       struct cifs_search_info *srch_inf);
+int SMB2_query_directory(const unsigned int xid, struct cifs_tcon *tcon,
+			 u64 persistent_fid, u64 volatile_fid, int index,
+			 struct cifs_search_info *srch_inf);
+int SMB2_set_info_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
+		       struct smb_rqst *rqst,
+		       u64 persistent_fid, u64 volatile_fid, u32 pid,
+		       u8 info_class, u8 info_type, u32 additional_info,
+		       void **data, unsigned int *size);
+void SMB2_set_info_free(struct smb_rqst *rqst);
+int SMB2_set_eof(const unsigned int xid, struct cifs_tcon *tcon, u64 persistent_fid,
+		 u64 volatile_fid, u32 pid, loff_t new_eof);
+int SMB2_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
+		 u64 persistent_fid, u64 volatile_fid,
+		 struct smb_ntsd *pnntsd, int pacllen, int aclflag);
+int SMB2_set_ea(const unsigned int xid, struct cifs_tcon *tcon,
+		u64 persistent_fid, u64 volatile_fid,
+		struct smb2_file_full_ea_info *buf, int len);
+int SMB2_oplock_break(const unsigned int xid, struct cifs_tcon *tcon,
+		      const u64 persistent_fid, const u64 volatile_fid,
+		      __u8 oplock_level);
+void smb2_copy_fs_info_to_kstatfs(struct smb2_fs_full_size_info *pfs_inf,
+				  struct kstatfs *kst);
+int SMB311_posix_qfs_info(const unsigned int xid, struct cifs_tcon *tcon,
+			  u64 persistent_fid, u64 volatile_fid, struct kstatfs *fsdata);
+int SMB2_QFS_attr(const unsigned int xid, struct cifs_tcon *tcon,
+		  u64 persistent_fid, u64 volatile_fid, int level);
+int smb2_lockv(const unsigned int xid, struct cifs_tcon *tcon,
+	       const __u64 persist_fid, const __u64 volatile_fid, const __u32 pid,
+	       const __u32 num_lock, struct smb2_lock_element *buf);
+int SMB2_lock(const unsigned int xid, struct cifs_tcon *tcon,
+	      const __u64 persist_fid, const __u64 volatile_fid, const __u32 pid,
+	      const __u64 length, const __u64 offset, const __u32 lock_flags,
+	      const bool wait);
+int SMB2_lease_break(const unsigned int xid, struct cifs_tcon *tcon,
+		     __u8 *lease_key, const __le32 lease_state);
+
+/*
+ * smb2transport.c
+ */
+int smb3_crypto_shash_allocate(struct TCP_Server_Info *server);
+struct cifs_tcon *smb2_find_smb_tcon(struct TCP_Server_Info *server, __u64 ses_id, __u32  tid);
+int generate_smb30signingkey(struct cifs_ses *ses,
+			     struct TCP_Server_Info *server);
+int generate_smb311signingkey(struct cifs_ses *ses,
+			      struct TCP_Server_Info *server);
+int smb2_verify_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server);
+int smb2_check_receive(struct mid_q_entry *mid, struct TCP_Server_Info *server,
+		       bool log_error);
+struct mid_q_entry *smb2_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *server,
+				       struct smb_rqst *rqst);
+struct mid_q_entry *smb2_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst *rqst);
+int smb3_crypto_aead_allocate(struct TCP_Server_Info *server);
+
+/*
+ * SMB2 Worker functions - most of protocol specific implementation details
+ * are contained within these calls.
+ */
+
+/* query path info from the server using SMB311 POSIX extensions*/
 
 #endif			/* _SMB2PROTO_H */
diff --git a/fs/smb/client/smbdirect.h b/fs/smb/client/smbdirect.h
index 73822800e36c..f600dc4a8eba 100644
--- a/fs/smb/client/smbdirect.h
+++ b/fs/smb/client/smbdirect.h
@@ -62,7 +62,6 @@ struct smbdirect_mr_io *smbd_register_mr(
 	bool writing, bool need_invalidate);
 void smbd_deregister_mr(struct smbdirect_mr_io *mr);
 
-/* PROTOTYPES */
 
 #else
 #define cifs_rdma_enabled(server)	0


