Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C4571390
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 10:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbfGWIHE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 04:07:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727375AbfGWIHE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:07:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 682AA308421A;
        Tue, 23 Jul 2019 08:07:03 +0000 (UTC)
Received: from localhost (ovpn-117-177.ams2.redhat.com [10.36.117.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 542BF5B684;
        Tue, 23 Jul 2019 08:07:02 +0000 (UTC)
Date:   Tue, 23 Jul 2019 09:07:01 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>, linux-fsdevel@vger.kernel.org
Subject: EIO with io_uring O_DIRECT writes on ext4
Message-ID: <20190723080701.GA3198@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 23 Jul 2019 08:07:03 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
io_uring O_DIRECT writes can fail with EIO on ext4.  Please see the
function graph trace from Linux 5.3.0-rc1 below for details.  It was
produced with the following qemu-io command (using Aarushi's QEMU
patches from https://github.com/rooshm/qemu/commits/io_uring):

  $ qemu-io --cache=none --aio=io_uring --format=qcow2 -c 'writev -P 185 131072 65536' tests/qemu-iotests/scratch/test.qcow2

This issue is specific to ext4.  XFS and the underlying LVM logical
volume both work.

The storage configuration is an LVM logical volume (device-mapper linear
target), on top of LUKS, on top of a SATA disk.  The logical volume's
request_queue does not have mq_ops and this causes
generic_make_request_checks() to fail:

  if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_mq(q))
          goto not_supported;

I guess this could be worked around by deferring the request to the
io_uring work queue to avoid REQ_NOWAIT.  But XFS handles this fine so
how can io_uring.c detect this case cleanly or is there a bug in ext4?

Stefan
---

 2)               |  __x64_sys_io_uring_enter() {
 2)               |    __fdget() {
 2)               |      __fget_light() {
 2)   0.207 us    |        __fget();
 2)   0.683 us    |      }
 2)   1.097 us    |    }
 2)               |    mutex_lock() {
 2)               |      _cond_resched() {
 2)               |        rcu_note_context_switch() {
 2)   0.233 us    |          rcu_qs();
 2)   0.700 us    |        }
 2)   0.235 us    |        _raw_spin_lock();
 2)   0.258 us    |        update_rq_clock();
 2)               |        pick_next_task_fair() {
 2)               |          update_curr() {
 2)   0.240 us    |            __calc_delta();
 2)   0.262 us    |            update_min_vruntime();
 2)   1.240 us    |          }
 2)   0.227 us    |          check_cfs_rq_runtime();
 2)               |          pick_next_entity() {
 2)   0.235 us    |            wakeup_preempt_entity.isra.0();
 2)   0.274 us    |            clear_buddies();
 2)   1.218 us    |          }
 2)               |          put_prev_entity() {
 2)               |            update_curr() {
 2)   0.222 us    |              update_min_vruntime();
 2)   0.226 us    |              cpuacct_charge();
 2)               |              __cgroup_account_cputime() {
 2)   0.226 us    |                cgroup_rstat_updated();
 2)   0.672 us    |              }
 2)   2.021 us    |            }
 2)   0.225 us    |            check_cfs_rq_runtime();
 2)   0.242 us    |            __enqueue_entity();
 2)   0.209 us    |            __update_load_avg_se();
 2)   0.183 us    |            __update_load_avg_cfs_rq();
 2)   4.119 us    |          }
 2)               |          put_prev_entity() {
 2)   0.235 us    |            update_curr();
 2)   0.237 us    |            check_cfs_rq_runtime();
 2)   0.274 us    |            __enqueue_entity();
 2)   0.246 us    |            __update_load_avg_se();
 2)   0.220 us    |            __update_load_avg_cfs_rq();
 2)   2.550 us    |          }
 2)               |          set_next_entity() {
 2)   0.266 us    |            __update_load_avg_se();
 2)   0.223 us    |            __update_load_avg_cfs_rq();
 2)   1.263 us    |          }
 2) + 12.628 us   |        }
 2)   0.237 us    |        enter_lazy_tlb();
 2)   0.277 us    |        finish_task_switch();
 2) + 25.560 us   |      }
 2) + 26.057 us   |    }
 2)               |    io_ring_submit() {
 2)   0.280 us    |      io_get_sqring.isra.0();
 2)               |      io_submit_sqe() {
 2)               |        kmem_cache_alloc() {
 2)               |          _cond_resched() {
 2)   0.230 us    |            rcu_all_qs();
 2)   0.697 us    |          }
 2)   0.226 us    |          should_failslab();
 2)   0.209 us    |          memcg_kmem_put_cache();
 2)   2.141 us    |        }
 2)               |        fget() {
 2)   0.263 us    |          __fget();
 2)   0.705 us    |        }
 2)               |        io_queue_sqe() {
 2)               |          __io_submit_sqe() {
 2)               |            io_write() {
 2)   0.303 us    |              io_prep_rw();
 2)               |              io_import_iovec.isra.0() {
 2)               |                rw_copy_check_uvector() {
 2)               |                  __check_object_size() {
 2)   0.255 us    |                    check_stack_object();
 2)   0.708 us    |                  }
 2)   1.296 us    |                }
 2)   1.854 us    |              }
 2)               |              rw_verify_area() {
 2)               |                security_file_permission() {
 2)               |                  selinux_file_permission() {
 2)               |                    __inode_security_revalidate() {
 2)               |                      _cond_resched() {
 2)   0.219 us    |                        rcu_all_qs();
 2)   0.666 us    |                      }
 2)   1.143 us    |                    }
 2)   0.207 us    |                    avc_policy_seqno();
 2)   2.090 us    |                  }
 2)   2.759 us    |                }
 2)   3.161 us    |              }
 2)               |              __sb_start_write() {
 2)               |                _cond_resched() {
 2)   0.223 us    |                  rcu_all_qs();
 2)   0.662 us    |                }
 2)   1.195 us    |              }
 2)               |              ext4_file_write_iter() {
 2)   0.221 us    |                down_write_trylock();
 2)               |                ext4_write_checks() {
 2)   0.238 us    |                  generic_write_check_limits.isra.0();
 2)   0.739 us    |                }
 2)               |                ext4_map_blocks() {
 2)               |                  ext4_es_lookup_extent() {
 2)   0.231 us    |                    _raw_read_lock();
 2)   0.728 us    |                  }
 2)               |                  __check_block_validity.constprop.0() {
 2)   0.294 us    |                    ext4_data_block_valid();
 2)   0.796 us    |                  }
 2)   2.211 us    |                }
 2)               |                __generic_file_write_iter() {
 2)   0.225 us    |                  file_remove_privs();
 2)               |                  file_update_time() {
 2)               |                    current_time() {
 2)   0.225 us    |                      ktime_get_coarse_real_ts64();
 2)   0.244 us    |                      timespec64_trunc();
 2)   1.155 us    |                    }
 2)   0.307 us    |                    __mnt_want_write_file();
 2)               |                    generic_update_time() {
 2)               |                      __mark_inode_dirty() {
 2)               |                        ext4_dirty_inode() {
 2)               |                          __ext4_journal_start_sb() {
 2)               |                            ext4_journal_check_start() {
 2)               |                              _cond_resched() {
 2)   9.606 us    |                                rcu_all_qs();
 2) + 10.042 us   |                              }
 2) + 10.507 us   |                            }
 2)               |                            jbd2__journal_start() {
 2)               |                              kmem_cache_alloc() {
 2)               |                                _cond_resched() {
 2)   0.208 us    |                                  rcu_all_qs();
 2)   0.608 us    |                                }
 2)   0.207 us    |                                should_failslab();
 2)   0.257 us    |                                memcg_kmem_put_cache();
 2)   2.063 us    |                              }
 2)               |                              start_this_handle() {
 2)   0.218 us    |                                _raw_read_lock();
 2)   0.248 us    |                                add_transaction_credits();
 2)   1.308 us    |                              }
 2)   4.047 us    |                            }
 2) + 15.251 us   |                          }
 2)               |                          ext4_mark_inode_dirty() {
 2)               |                            _cond_resched() {
 2)   0.194 us    |                              rcu_all_qs();
 2)   0.616 us    |                            }
 2)               |                            ext4_reserve_inode_write() {
 2)               |                              __ext4_get_inode_loc() {
 2)   0.325 us    |                                ext4_get_group_desc();
 2)   0.238 us    |                                ext4_inode_table();
 2)               |                                __getblk_gfp() {
 2)               |                                  __find_get_block() {
 2)   0.265 us    |                                    mark_page_accessed();
 2)   1.071 us    |                                  } /* __find_get_block */
 2)               |                                  _cond_resched() {
 2)   0.211 us    |                                    rcu_all_qs();
 2)   0.643 us    |                                  }
 2)   2.560 us    |                                }
 2)   4.076 us    |                              }
 2)               |                              __ext4_journal_get_write_access() {
 2)               |                                _cond_resched() {
 2)   0.174 us    |                                  rcu_all_qs();
 2)   0.609 us    |                                }
 2)               |                                jbd2_journal_get_write_access() {
 2)   0.259 us    |                                  jbd2_write_access_granted();
 2)   0.695 us    |                                }
 2)   1.937 us    |                              }
 2)   6.681 us    |                            }
 2)               |                            ext4_mark_iloc_dirty() {
 2)   0.205 us    |                              _raw_spin_lock();
 2)               |                              from_kuid() {
 2)   0.196 us    |                                map_id_up();
 2)   0.604 us    |                              }
 2)               |                              from_kgid() {
 2)   0.223 us    |                                map_id_up();
 2)   0.641 us    |                              }
 2)               |                              from_kprojid() {
 2)   0.221 us    |                                map_id_up();
 2)   0.644 us    |                              }
 2)               |                              ext4_inode_csum_set() {
 2)               |                                ext4_inode_csum.isra.0() {
 2)               |                                  crypto_shash_update() {
 2)   0.309 us    |                                    crc32c_pcl_intel_update [crc32c_intel]();
 2)   0.956 us    |                                  }
 2)               |                                  crypto_shash_update() {
 2)   0.250 us    |                                    crc32c_pcl_intel_update [crc32c_intel]();
 2)   0.692 us    |                                  }
 2)               |                                  crypto_shash_update() {
 2)   0.244 us    |                                    crc32c_pcl_intel_update [crc32c_intel]();
 2)   0.662 us    |                                  }
 2)               |                                  crypto_shash_update() {
 2)   0.172 us    |                                    crc32c_pcl_intel_update [crc32c_intel]();
 2)   0.562 us    |                                  }
 2)               |                                  crypto_shash_update() {
 2)   0.223 us    |                                    crc32c_pcl_intel_update [crc32c_intel]();
 2)   0.658 us    |                                  }
 2)               |                                  crypto_shash_update() {
 2)   0.236 us    |                                    crc32c_pcl_intel_update [crc32c_intel]();
 2)   0.681 us    |                                  }
 2)   5.786 us    |                                }
 2)   6.383 us    |                              }
 2)               |                              __ext4_handle_dirty_metadata() {
 2)               |                                _cond_resched() {
 2)   0.220 us    |                                  rcu_all_qs();
 2)   0.649 us    |                                }
 2)   0.250 us    |                                jbd2_journal_dirty_metadata();
 2)   1.576 us    |                              }
 2)   0.208 us    |                              __brelse();
 2) + 12.384 us   |                            }
 2) + 20.577 us   |                          }
 2)               |                          __ext4_journal_stop() {
 2)               |                            jbd2_journal_stop() {
 2)               |                              __wake_up() {
 2)               |                                __wake_up_common_lock() {
 2)   0.222 us    |                                  _raw_spin_lock_irqsave();
 2)   0.218 us    |                                  __wake_up_common();
 2)   0.216 us    |                                  _raw_spin_unlock_irqrestore();
 2)   1.485 us    |                                }
 2)   1.902 us    |                              }
 2)   0.347 us    |                              kmem_cache_free();
 2)   3.030 us    |                            }
 2)   3.521 us    |                          }
 2) + 40.202 us   |                        }
 2) + 40.826 us   |                      }
 2) + 41.419 us   |                    }
 2)   0.204 us    |                    __mnt_drop_write_file();
 2) + 44.224 us   |                  }
 2)               |                  generic_file_direct_write() {
 2)   0.337 us    |                    filemap_range_has_page();
 2)   0.336 us    |                    invalidate_inode_pages2_range();
 2)               |                    ext4_direct_IO() {
 2)               |                      __blockdev_direct_IO() {
 2)               |                        kmem_cache_alloc() {
 2)               |                          _cond_resched() {
 2)   0.210 us    |                            rcu_all_qs();
 2)   0.660 us    |                          }
 2)   0.225 us    |                          should_failslab();
 2)   0.215 us    |                          memcg_kmem_put_cache();
 2)   2.042 us    |                        }
 2)   0.229 us    |                        blk_start_plug();
 2)               |                        get_user_pages_fast() {
 2)               |                          gup_pgd_range() {
 2)   0.226 us    |                            pud_huge();
 2)   0.212 us    |                            pmd_huge();
 2)   1.862 us    |                          }
 2)   2.330 us    |                        }
 2)               |                        ext4_dio_get_block_unwritten_async() {
 2)               |                          ext4_get_block_trans() {
 2)               |                            ext4_meta_trans_blocks() {
 2)   0.231 us    |                              ext4_ext_index_trans_blocks();
 2)   0.775 us    |                            }
 2)               |                            __ext4_journal_start_sb() {
 2)               |                              ext4_journal_check_start() {
 2)               |                                _cond_resched() {
 2)   0.210 us    |                                  rcu_all_qs();
 2)   0.636 us    |                                }
 2)   1.078 us    |                              }
 2)               |                              jbd2__journal_start() {
 2)               |                                kmem_cache_alloc() {
 2)               |                                  _cond_resched() {
 2)   0.211 us    |                                    rcu_all_qs();
 2)   0.643 us    |                                  }
 2)   0.216 us    |                                  should_failslab();
 2)   0.223 us    |                                  memcg_kmem_put_cache();
 2)   1.993 us    |                                }
 2)               |                                start_this_handle() {
 2)   0.213 us    |                                  _raw_read_lock();
 2)   0.237 us    |                                  add_transaction_credits();
 2)   1.139 us    |                                }
 2)   3.808 us    |                              }
 2)   5.548 us    |                            }
 2)               |                            _ext4_get_block() {
 2)               |                              ext4_map_blocks() {
 2)               |                                ext4_es_lookup_extent() {
 2)   0.211 us    |                                  _raw_read_lock();
 2)   0.686 us    |                                }
 2)               |                                __check_block_validity.constprop.0() {
 2)   0.248 us    |                                  ext4_data_block_valid();
 2)   0.673 us    |                                }
 2)   2.023 us    |                              }
 2)   0.177 us    |                              ext4_update_bh_state();
 2)   2.809 us    |                            }
 2)               |                            __ext4_journal_stop() {
 2)               |                              jbd2_journal_stop() {
 2)               |                                __wake_up() {
 2)               |                                  __wake_up_common_lock() {
 2)   0.219 us    |                                    _raw_spin_lock_irqsave();
 2)   0.236 us    |                                    __wake_up_common();
 2)   0.226 us    |                                    _raw_spin_unlock_irqrestore();
 2)   1.539 us    |                                  }
 2)   1.950 us    |                                }
 2)   0.191 us    |                                kmem_cache_free();
 2)   2.770 us    |                              }
 2)   3.191 us    |                            }
 2) + 13.443 us   |                          }
 2) + 13.901 us   |                        }
 2)               |                        bio_alloc_bioset() {
 2)               |                          mempool_alloc() {
 2)               |                            _cond_resched() {
 2)   0.215 us    |                              rcu_all_qs();
 2)   0.655 us    |                            }
 2)               |                            mempool_alloc_slab() {
 2)               |                              kmem_cache_alloc() {
 2)   0.184 us    |                                should_failslab();
 2)   0.171 us    |                                memcg_kmem_put_cache();
 2)   0.958 us    |                              }
 2)   1.372 us    |                            }
 2)   2.724 us    |                          }
 2)   0.229 us    |                          bio_init();
 2)               |                          bvec_alloc() {
 2)               |                            kmem_cache_alloc() {
 2)   0.217 us    |                              should_failslab();
 2)   0.228 us    |                              memcg_kmem_put_cache();
 2)   1.259 us    |                            }
 2)   1.723 us    |                          }
 2)   5.627 us    |                        }
 2)               |                        bio_associate_blkg() {
 2)   0.202 us    |                          kthread_blkcg();
 2)               |                          bio_associate_blkg_from_css() {
 2)   0.313 us    |                            __bio_associate_blkg.isra.0();
 2)   0.761 us    |                          }
 2)   1.676 us    |                        }
 2)               |                        bio_add_page() {
 2)   0.220 us    |                          __bio_try_merge_page();
 2)   0.238 us    |                          __bio_add_page();
 2)   1.092 us    |                        }
 2)               |                        bio_add_page() {
 2)   0.250 us    |                          __bio_try_merge_page();
 2)   0.229 us    |                          __bio_add_page();
 2)   1.132 us    |                        }
 2)               |                        bio_add_page() {
 2)   0.174 us    |                          __bio_try_merge_page();
 2)   0.220 us    |                          __bio_add_page();
 2)   0.965 us    |                        }
 2)               |                        bio_add_page() {
 2)   0.220 us    |                          __bio_try_merge_page();
 2)   0.218 us    |                          __bio_add_page();
 2)   1.086 us    |                        }
 2)               |                        bio_add_page() {
 2)   0.218 us    |                          __bio_try_merge_page();
 2)   0.226 us    |                          __bio_add_page();
 2)   1.082 us    |                        }
 2)               |                        bio_add_page() {
 2)   0.190 us    |                          __bio_try_merge_page();
 2)   0.224 us    |                          __bio_add_page();
 2)   1.014 us    |                        }
 2)               |                        bio_add_page() {
 2)   0.218 us    |                          __bio_try_merge_page();
 2)   0.211 us    |                          __bio_add_page();
 2)   1.066 us    |                        }
 2)               |                        bio_add_page() {
 2)   0.227 us    |                          __bio_try_merge_page();
 2)   0.213 us    |                          __bio_add_page();
 2)   1.039 us    |                        }
 2)               |                        bio_add_page() {
 2)   0.230 us    |                          __bio_try_merge_page();
 2)   0.218 us    |                          __bio_add_page();
 2)   1.073 us    |                        }
 2)               |                        bio_add_page() {
 2)   0.220 us    |                          __bio_try_merge_page();
 2)   0.211 us    |                          __bio_add_page();
 2)   1.081 us    |                        }
 2)               |                        bio_add_page() {
 2)   0.229 us    |                          __bio_try_merge_page();
 2)   0.171 us    |                          __bio_add_page();
 2)   0.996 us    |                        }
 2)               |                        bio_add_page() {
 2)   0.224 us    |                          __bio_try_merge_page();
 2)   0.218 us    |                          __bio_add_page();
 2)   1.073 us    |                        }
 2)               |                        bio_add_page() {
 2)   0.222 us    |                          __bio_try_merge_page();
 2)   0.224 us    |                          __bio_add_page();
 2)   1.091 us    |                        }
 2)               |                        bio_add_page() {
 2)   0.176 us    |                          __bio_try_merge_page();
 2)   0.224 us    |                          __bio_add_page();
 2)   1.009 us    |                        }
 2)               |                        bio_add_page() {
 2)   0.224 us    |                          __bio_try_merge_page();
 2)   0.227 us    |                          __bio_add_page();
 2)   1.105 us    |                        }
 2)               |                        bio_add_page() {
 2)   0.222 us    |                          __bio_try_merge_page();
 2)   0.221 us    |                          __bio_add_page();
 2)   1.139 us    |                        }
 2)   0.216 us    |                        _raw_spin_lock_irqsave();
 2)   0.356 us    |                        _raw_spin_unlock_irqrestore();
 2)               |                        submit_bio() {
 2)               |                          generic_make_request() {
 2)               |                            generic_make_request_checks() {
 2)               |                              _cond_resched() {
 2)   0.224 us    |                                rcu_all_qs();
 2)   0.653 us    |                              }
 2)               |                              bio_endio() {
 2)               |                                __rq_qos_done_bio() {
 2)               |                                  blkcg_iolatency_done_bio() {
 2)   0.272 us    |                                    ktime_get();
 2)   0.738 us    |                                  }
 2)   1.264 us    |                                }
 2)               |                                dio_bio_end_aio() {
 2)               |                                  dio_bio_complete() {
 2)               |                                    bio_release_pages() {
 2)   0.433 us    |                                      bio_release_pages.part.0();
 2)   0.870 us    |                                    }
 2)               |                                    bio_put() {
 2)               |                                      bio_free() {
 2)               |                                        bvec_free() {
 2)   0.237 us    |                                          kmem_cache_free();
 2)   0.696 us    |                                        } /* bvec_free */
 2)               |                                        mempool_free() {
 2)               |                                          mempool_free_slab() {
 2)   0.237 us    |                                            kmem_cache_free();
 2)   0.619 us    |                                          }
 2)   1.002 us    |                                        }
 2)   2.337 us    |                                      }
 2)   2.770 us    |                                    }
 2)   4.270 us    |                                  }
 2)   0.216 us    |                                  _raw_spin_lock_irqsave();
 2)   0.227 us    |                                  _raw_spin_unlock_irqrestore();
 2)   5.584 us    |                                }
 2)   7.567 us    |                              }
 2)   8.915 us    |                            }
 2)   9.398 us    |                          }
 2)   9.849 us    |                        }
 2)               |                        blk_finish_plug() {
 2)   0.246 us    |                          blk_flush_plug_list();
 2)   0.701 us    |                        }
 2)   0.227 us    |                        _raw_spin_lock_irqsave();
 2)   0.225 us    |                        _raw_spin_unlock_irqrestore();
 2)               |                        dio_complete() {
 2)   0.224 us    |                          ext4_end_io_dio();
 2)   0.259 us    |                          kmem_cache_free();
 2)   1.215 us    |                        }
 2) + 63.921 us   |                      }
 2)               |                      wake_up_bit() {
 2)   0.221 us    |                        __wake_up_bit();
 2)   0.703 us    |                      }
 2) + 65.463 us   |                    }
 2) + 67.271 us   |                  }
 2) ! 112.659 us  |                }
 2)   0.219 us    |                up_write();
 2) ! 117.784 us  |              }
 2)               |              io_complete_rw() {
 2)               |                kiocb_end_write.isra.0.part.0() {
 2)   0.242 us    |                  __sb_end_write();
 2)   0.723 us    |                }
 2)               |                io_cqring_add_event() {
 2)   0.221 us    |                  _raw_spin_lock_irqsave();
 2)   0.254 us    |                  io_commit_cqring();
 2)   0.215 us    |                  _raw_spin_unlock_irqrestore();
 2)   0.225 us    |                  io_cqring_ev_posted();
 2)   1.958 us    |                }
 2)   0.218 us    |                io_put_req();
 2)   3.795 us    |              }
 2)   0.219 us    |              kfree();
 2) ! 130.276 us  |            }
 2) ! 130.807 us  |          }
 2)               |          io_put_req() {
 2)               |            io_free_req() {
 2)               |              __io_free_req() {
 2)               |                fput() {
 2)   0.223 us    |                  fput_many();
 2)   0.636 us    |                }
 2)   0.230 us    |                io_ring_drop_ctx_refs();
 2)   0.242 us    |                kmem_cache_free();
 2)   1.993 us    |              }
 2)   2.376 us    |            }
 2)   2.781 us    |          }
 2) ! 134.263 us  |        }
 2) ! 138.150 us  |      }
 2) ! 139.215 us  |    }
 2)   0.230 us    |    mutex_unlock();
 2)   0.234 us    |    io_cqring_wait();
 2)   0.230 us    |    io_ring_drop_ctx_refs();
 2)               |    fput() {
 2)   0.209 us    |      fput_many();
 2)   0.617 us    |    }
 2) ! 186.975 us  |  }

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl02wAsACgkQnKSrs4Gr
c8hSWwf9Ff41hqesZb+ksQUdATUE4L0hmati8n4/6YIxy8pIQYFVoTkrRlsfrHj8
kHz8HfPjasfLLaE77wVgt/0Aok06vFW0gwqAuBXmYv03mR753yA1SidHVQK8oDvb
ZAqK7pxPTdvE8MI4a8D5PMh0EvKOMGewl1Glq4sl9OnttujQhTNPfvWvn3lokI3Y
YhUNpJLkk4RgQcsLp3SzxyPEN04QEhieyzSS45lRqYaHpb+n6lBaAvNED5Vzxc1X
Fi8DcEztdIeiGd97lmQns0uaIMtUZvVOvs9oUXTcgugIhthRqcJ7x5xU3uLvpQUV
zIuHMWO1bIVsqBBeJVF4rG8p0j3WBQ==
=rprh
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
